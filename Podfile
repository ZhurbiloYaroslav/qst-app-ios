source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target 'QuitSmokingTogether' do

	pod 'FolioReaderKit'
	pod 'FacebookCore'
	pod 'FacebookLogin'
	pod 'FacebookShare'
	pod 'Firebase/Core'
	pod 'Firebase/Auth'
	pod 'Firebase/Database'
	pod 'KeychainSwift', '~> 9.0' # https://github.com/evgenyneu/keychain-swift
	pod "CLabsImageSlider", '~> 0.1.2'

end

post_install do |installer|
        myTargets = ['FolioReaderKit', 'FontBlaster', 'MenuItemKit', "CLabsImageSlider"]

        installer.pods_project.targets.each do |target|
                if myTargets.include? target.name
                        target.build_configurations.each do |config|
                                config.build_settings['SWIFT_VERSION'] = '3.2'
                        end
                end
        end
end
