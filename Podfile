# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

use_frameworks!

def share_pods
  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'
  pod 'NSObject+Rx', '5.2.1'
  pod 'Alamofire', '5.4.3'
  pod 'SwiftLint', '0.45.0'
end

def testing_pods
  pod 'RxBlocking', '6.2.0'
  pod 'RxTest', '6.2.0'
end

target 'MovieDB' do
  share_pods
end

target 'MovieDBTests' do
  inherit! :search_paths
  share_pods
  testing_pods
end