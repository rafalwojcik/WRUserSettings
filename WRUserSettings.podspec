Pod::Spec.new do |s|
   s.name     = 'WRUserSettings'
   s.version  = '1.0.2'
   s.license  = 'MIT'
   s.summary  = 'Magical User settings class for iOS.'
   s.homepage = 'https://github.com/rafalwojcik/WRUserSettings'
   s.authors  = 'Rafał Wójcik'
   s.source   = { :git => 'https://github.com/rafalwojcik/WRUserSettings.git', :tag => s.version.to_s }

   s.platform     = :ios, '7.0'
   s.ios.deployment_target = '7.0'
   s.requires_arc = true   
   s.framework = "UIKit"
   s.source_files = "WRUserSettings/**/*.{h,m}"
   s.header_dir = 'WRUserSettings'
   s.public_header_files = 'WRUserSettings/**/*.h'
end

