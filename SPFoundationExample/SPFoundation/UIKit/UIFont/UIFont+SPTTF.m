//
//  UIFont+SPTTF.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UIFont+SPTTF.h"
#import <CoreText/CoreText.h>

#if  ! __has_feature(objc_arc)
#error This file must be compiled with ARC.
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 40100
#error This file must be compiled with Deployment Target greater or equal to 4.1
#endif

// Activate Xcode only logging
#ifdef DEBUG
#define UIFontWDCustomLoaderDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define UIFontWDCustomLoaderDLog(...)
#endif

static CGFloat const kSizePlaceholder = 1.0f;
static NSMutableDictionary *appRegisteredCustomFonts = nil;

@implementation UIFont (SPTTF)

+ (UIFont *)fontWithTTFAtURL:(NSURL *)URL size:(CGFloat)size
{
    BOOL isLocalFile = [URL isFileURL];
    NSAssert(isLocalFile, @"TTF files may only be loaded from local file paths. Remote files must first be cached locally, this category does not handle such cases natively.\n\nIf, however, the provided URL is indeed a reference to a local file.\n\n1. Ensure it was created via a method such as [NSURL fileURLWithPath:] and NOT [NSURL URLWithString:].\n\n2. Ensure the URL returns YES to isFileURL.");
    if (!isLocalFile)
    {
        return [UIFont systemFontOfSize:size];
    }
    return [UIFont fontWithTTFAtPath:URL.path size:size];
}

+ (UIFont *)fontWithTTFAtPath:(NSString *)path size:(CGFloat)size
{
    BOOL foundFile = [[NSFileManager defaultManager] fileExistsAtPath:path];
    NSAssert(foundFile, @"The font at: \"%@\" was not found.", path);
    if (!foundFile)
    {
        return [UIFont systemFontOfSize:size];
    }
    
    CFURLRef fontURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (__bridge CFStringRef)path, kCFURLPOSIXPathStyle, false);;
    CGDataProviderRef dataProvider = CGDataProviderCreateWithURL(fontURL);
    CFRelease(fontURL);
    CGFontRef graphicsFont = CGFontCreateWithDataProvider(dataProvider);
    CFRelease(dataProvider);
    CTFontRef smallFont = CTFontCreateWithGraphicsFont(graphicsFont, size, NULL, NULL);
    CFRelease(graphicsFont);
    
    UIFont *returnFont = (__bridge UIFont *)smallFont;
    CFRelease(smallFont);
    
    return returnFont;
}

+ (BOOL)deviceHasFullSupportForFontCollections
{
    return (&CTFontManagerCreateFontDescriptorsFromURL != NULL); // 10.6 or 7.0
}

+ (BOOL)registerFromURL:(NSURL *)fontURL
{
    CFErrorRef error;
    BOOL registrationResult = YES;
    
    registrationResult = CTFontManagerRegisterFontsForURL((__bridge CFURLRef)fontURL, kCTFontManagerScopeProcess, &error);
    
    if (!registrationResult) {
        UIFontWDCustomLoaderDLog(@"Error with font registration: %@", error);
        CFRelease(error);
        return NO;
    }
    return YES;
}

+ (BOOL)registerFromCGFont:(CGFontRef)fontRef
{
    CFErrorRef error;
    BOOL registrationResult = YES;
    
    registrationResult = CTFontManagerRegisterGraphicsFont(fontRef, &error);
    
    if (!registrationResult) {
        UIFontWDCustomLoaderDLog(@"Error with font registration: %@", error);
        CFRelease(error);
        return NO;
    }
    
    return YES;
    
}

+ (NSArray *)registerFontFromURL:(NSURL *)fontURL
{
    // Dictionary creation
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appRegisteredCustomFonts = [NSMutableDictionary new];
    });
    
    // Result
    NSArray *fontPSNames = nil;
    
    
    // Critical section
    @synchronized(appRegisteredCustomFonts) {
        
        // Check if this library knows this url
        fontPSNames = [[appRegisteredCustomFonts objectForKey:fontURL] copy];
        
        if (fontPSNames == nil) {
            
            // Check features
            if ([UIFont deviceHasFullSupportForFontCollections]) {
                
                // Retrieve font descriptors from ttf, otf, ttc and otc files
                NSArray *fontDescriptors = (__bridge_transfer NSArray *)(CTFontManagerCreateFontDescriptorsFromURL((__bridge CFURLRef)fontURL));
                
                // Check errors
                if (fontDescriptors) {
                    
                    // Check how many fonts are already registered (or have the
                    // same name of another font)
                    NSMutableArray *verifiedFontPSNames = [NSMutableArray new];
                    
                    for (NSDictionary *fontDescriptor in fontDescriptors) {
                        NSString *fontPSName = [fontDescriptor objectForKey:@"NSFontNameAttribute"];
                        
                        if (fontPSName) {
                            if ([UIFont fontWithName:fontPSName size:kSizePlaceholder]) {
                                UIFontWDCustomLoaderDLog(@"Warning with font registration: Font '%@' already registered",fontPSName);
                            }
                            [verifiedFontPSNames addObject:fontPSName];
                        }
                    }
                    
                    fontPSNames = [NSArray arrayWithArray:verifiedFontPSNames];
                    
                    // At least one
                    if ([fontPSNames count] > 0) {
                        
                        // If registration went ok
                        if ([UIFont registerFromURL:fontURL]) {
                            // Add url to this library
                            [appRegisteredCustomFonts setObject:fontPSNames
                                                         forKey:fontURL];
                            
                        } else {
                            fontPSNames = nil;
                        }
                        
                    } else { // [fontPSNames count] <= 0
                        UIFontWDCustomLoaderDLog(@"Warning with font registration: All fonts in '%@' are already registered", fontURL);
                    }
                    
                } else { // CTFontManagerCreateFontDescriptorsFromURL fail
                    UIFontWDCustomLoaderDLog(@"Error with font registration: File '%@' is not a Font", fontURL);
                    fontPSNames = nil;
                }
            } else { // [UIFont deviceHasFullSupportForFontCollections] fail
                
                // Read data
                NSError *error;
                NSData *fontData = [NSData dataWithContentsOfURL:fontURL
                                                         options:NSDataReadingUncached
                                                           error:&error];
                
                // Check data creation
                if (fontData) {
                    
                    // Load font
                    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
                    CGFontRef loadedFont = CGFontCreateWithDataProvider(fontDataProvider);
                    
                    // Check font
                    if (loadedFont != NULL) {
                        
                        // Prior to iOS7 is not easy to retrieve names from font collections
                        // But is possible to register collections
                        NSSet *singleFontValidExtensions = [NSSet setWithArray:@[@"ttf", @"otf"]];
                        
                        if ([singleFontValidExtensions containsObject:[fontURL pathExtension]]) {
                            // Read name
                            fontPSNames = @[(__bridge_transfer NSString *)(CGFontCopyPostScriptName(loadedFont))];
                            
                            // Check if registration is required
                            if ([UIFont fontWithName:fontPSNames[0] size:kSizePlaceholder] == nil) {
                                
                                // If registration went ok
                                if ([UIFont registerFromCGFont:loadedFont]) {
                                    // Add url to this library
                                    [appRegisteredCustomFonts setObject:fontPSNames
                                                                 forKey:fontURL];
                                    
                                } else {
                                    fontPSNames = nil;
                                }
                            } else {
                                UIFontWDCustomLoaderDLog(@"Warning with font registration: All fonts in '%@' are already registered", fontURL);
                            }
                            
                        } else {
                            // Is a collection
                            
                            //TODO find a way to read names
                            fontPSNames = @[];
                            
                            // Revert to url registration which allow collections
                            // If registration went ok
                            if ([UIFont registerFromURL:fontURL]) {
                                // Add url to this library
                                [appRegisteredCustomFonts setObject:fontPSNames
                                                             forKey:fontURL];
                                
                            } else {
                                fontPSNames = nil;
                            }
                        }
                        
                    } else { // CGFontCreateWithDataProvider fail
                        UIFontWDCustomLoaderDLog(@"Error with font registration: File '%@' is not a Font", fontURL);
                        fontPSNames = nil;
                    }
                    
                    // Release
                    CGFontRelease(loadedFont);
                    CGDataProviderRelease(fontDataProvider);
                } else {
                    UIFontWDCustomLoaderDLog(@"Error with font registration: URL '%@' cannot be read with error: %@", fontURL, error);
                    fontPSNames = nil;
                }
                
            }
            
        }
        
    }
    
    return fontPSNames;
}

+ (UIFont *)customFontWithURL:(NSURL *)fontURL size:(CGFloat)size {
    
    // Only single font with this method
    NSSet *singleFontValidExtensions = [NSSet setWithArray:@[@"ttf", @"otf"]];
    
    if (![singleFontValidExtensions containsObject:[fontURL pathExtension]]) {
        UIFontWDCustomLoaderDLog(@"Only ttf or otf files are supported by this method");
        return nil;
    }
    
    NSArray *fontPSNames = [UIFont registerFontFromURL:fontURL];
    
    if (fontPSNames == nil) {
        UIFontWDCustomLoaderDLog(@"Invalid Font URL: %@", fontURL);
        return nil;
    }
    if ([fontPSNames count] != 1) {
        UIFontWDCustomLoaderDLog(@"Font collections not supported by this method");
        return nil;
    }
    return [UIFont fontWithName:fontPSNames[0] size:size];
}

+ (UIFont *)customFontOfSize:(CGFloat)size withName:(NSString *)name withExtension:(NSString *)extension
{
    // Get url for font resource
    NSURL *fontURL = [[[NSBundle mainBundle] URLForResource:name withExtension:extension] absoluteURL];
    
    return [UIFont customFontWithURL:fontURL size:size];
}

@end
