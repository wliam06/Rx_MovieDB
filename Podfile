platform :ios, '9.0'
use_frameworks!

plugin 'cocoapods-pod-linkage'
plugin 'cocoapods-pod-merge'

workspace 'MovieDB.xcworkspace'

target 'MovieDB' do

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
  use_frameworks! :linkage => :static

  pod 'SnapKit'

  target 'MovieKitTests' do
    inherit! :search_paths
  end
end

target 'Networking' do
  project 'Networking/Networking.xcodeproj'
  use_frameworks! :linkage => :static
  pod 'NetworkSwift', path: 'MergedPods/NetworkSwift'
  # pod 'Kingfisher'
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