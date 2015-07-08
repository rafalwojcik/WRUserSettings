Pod::Spec.new do |s|
	s.name     = 'WRUserSettings'
	s.version  = '2.0.0'
	s.license  = 'MIT'
	s.summary  = 'Magical User settings class for iOS.'
	s.homepage = 'https://github.com/rafalwojcik/WRUserSettings'
	s.authors  = 'Rafał Wójcik'
	s.source   = { :git => 'https://github.com/rafalwojcik/WRUserSettings.git', :tag => s.version.to_s }
	
	s.platform = :ios, '8.0'
	s.ios.deployment_target = '8.0'
	s.requires_arc = true
	s.source_files = "WRUserSettings/**/*.swift"
end

