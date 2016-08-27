Pod::Spec.new do |s|
s.name     = 'SPFoundation'
s.version  = '1.2.2'
s.summary  = '本尊iOS常用.'
s.license = { :type => 'MIT', :file => 'LICENSE' }
s.homepage = 'https://github.com/lansepan/SPFoundation'
s.author = { "BluePan" => "243492212@qq.com" }
s.source = { :git => "https://github.com/lansepan/SPFoundation.git", :tag => s.version.to_s }
s.platform = :ios, "8.0"
s.requires_arc = true
s.framework = 'UIKit','MapKit','Security','Foundation','CoreLocation'
s.dependency 'TAPageControl'
s.dependency 'SDWebImage'

s.public_header_files = 'SPFoundationExample/SPFoundation/SPFoundation.h'
s.source_files = 'SPFoundationExample/SPFoundation/SPFoundation.h'

s.subspec 'Macros' do |ss|
ss.source_files = 'SPFoundationExample/SPFoundation/Macros/*.{h,m}'
end

s.subspec 'Helpers' do |ss|
ss.source_files = 'SPFoundationExample/SPFoundation/Helpers/*.{h,m}'
end

s.subspec 'Transition' do |ss|
ss.source_files = 'SPFoundationExample/SPFoundation/Transition/*.{h,m}'
end

s.subspec 'UIKit' do |ss|
ss.source_files = 'SPFoundationExample/SPFoundation/UIKit/**/*.{h,m}'
end

s.subspec 'Foundation' do |ss|
ss.source_files = 'SPFoundationExample/SPFoundation/Foundation/**/*.{h,m}'
end

s.subspec 'Classes' do |ss|
ss.source_files = 'SPFoundationExample/SPFoundation/Classes/**/*.{h,m}'
end

end