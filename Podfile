platform :ios, '9.0'
use_frameworks!

plugin 'cocoapods-pod-linkage'
plugin 'cocoapods-pod-merge'

workspace 'MovieDB.xcworkspace'

target 'MovieDB' do
  # pod 'UISwift', path: 'MergedPods/UISwift'
  # pod 'RxFrameworkSwift', path: 'MergedPods/RxFrameworkSwift'

  target 'MovieDBTests' do
    inherit! :search_paths
    # Pods for testing
    # testing_pods
  end
end

target 'Core' do
  project 'Core/Core.xcodeproj'

  target 'CoreTests' do
    inherit! :search_paths
  end
end

target 'MovieKit' do
  project 'MovieKit/MovieKit.xcodeproj'

  pod 'UISwift', path: 'MergedPods/UISwift'

  target 'MovieKitTests' do
    inherit! :search_paths
  end
end

target 'Networking' do
  project 'Networking/Networking.xcodeproj'

  pod 'NetworkSwift', path: 'MergedPods/NetworkSwift'
  pod 'Alamofire'

  target 'NetworkingTests' do
    inherit! :search_paths
  end
end

target 'RxFramework' do
  project 'RxFramework/RxFramework.xcodeproj'
  use_frameworks! :linkage => :static

  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'
  pod 'NSObject+Rx', '5.2.1'
  pod 'RxDataSources', '~> 5.0'
end