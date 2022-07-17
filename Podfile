platform :ios, '9.0'
use_frameworks!

plugin 'cocoapods-pod-linkage'
plugin 'cocoapods-pod-merge'

workspace 'MovieDB.xcworkspace'

# MainApp
target 'MovieDB' do
  target 'MovieDBTests' do
    inherit! :search_paths
    # Pods for testing
    # testing_pods
  end
end

# Features
target 'MovieList' do
  project 'MovieList/MovieList.xcodeproj'
  use_frameworks!
  target 'MovieListTests' do
    inherit! :search_paths
  end
end

target 'MovieDetail' do
  project 'MovieDetail/MovieDetail.xcodeproj'
  target 'MovieDetailTests' do
    inherit! :search_paths
  end
end

# Core
target 'Core' do
  project 'Core/Core.xcodeproj'

  target 'CoreTests' do
    inherit! :search_paths
  end
end

# UIKIt
target 'MovieKit' do
  project 'MovieKit/MovieKit.xcodeproj'
  use_frameworks! :linkage => :static

  pod 'SnapKit'

  target 'MovieKitTests' do
    inherit! :search_paths
  end
end

# Network
target 'Networking' do
  use_frameworks! :linkage => :static
  project 'Networking/Networking.xcodeproj'

  pod 'NetworkSwift', path: 'MergedPods/NetworkSwift'
  pod 'Alamofire'

  target 'NetworkingTests' do
    inherit! :search_paths
  end
end

# 3rd party custom
target 'RxFramework' do
  project 'RxFramework/RxFramework.xcodeproj'
  use_frameworks! :linkage => :static

  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'
  pod 'NSObject+Rx', '5.2.1'
  pod 'RxDataSources', '~> 5.0'
end