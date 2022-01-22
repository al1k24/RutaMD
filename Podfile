# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

use_frameworks!
inhibit_all_warnings!

source 'https://cdn.cocoapods.org/'

pod 'Alamofire'
pod 'SwiftyJSON'
pod 'SwiftSoup'

target 'RutaMD'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      config.build_settings['SWIFT_VERSION'] = '5.0'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end