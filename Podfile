source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target 'QuitSmokingTogether' do

	pod 'FolioReaderKit'
  pod 'CSV.swift', '~> 2.1.0'
	pod 'FacebookCore'
	pod 'FacebookLogin'
	pod 'FacebookShare'
	pod 'Firebase/Core'
	pod 'Firebase/Auth'
	pod 'KeychainSwift', '~> 9.0' # https://github.com/evgenyneu/keychain-swift

end

post_install do |installer|
        myTargets = ['FolioReaderKit', 'FontBlaster', 'MenuItemKit']

        installer.pods_project.targets.each do |target|
                if myTargets.include? target.name
                        target.build_configurations.each do |config|
                                config.build_settings['SWIFT_VERSION'] = '3.2'
                        end
                end
        end
end
