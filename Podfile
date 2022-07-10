platform :ios, '12.0'
inhibit_all_warnings!

plugin 'cocoapods-pod-merge'
workspace 'MovieDB.xcworkspace'

target 'MovieDB' do
  use_frameworks!
  pod 'UISwift', path: 'MergedPods/UISwift'
  pod 'RxFrameworkSwift', path: 'MergedPods/RxFrameworkSwift'

  target 'MovieDBTests' do
    inherit! :search_paths
    # Pods for testing
    # testing_pods
  end
end

target 'Core' do
  use_frameworks!
  project 'Core/Core.xcodeproj'
end

target 'MovieKit' do
  use_frameworks!
  project 'MovieKit/MovieKit.xcodeproj'

  pod 'RxFrameworkSwift', path: 'MergedPods/RxFrameworkSwift'
  pod 'UISwift', path: 'MergedPods/UISwift'
end

target 'Networking' do
  use_frameworks!
  project 'Networking/Networking.xcodeproj'

  # pod 'RxFrameworkSwift', path => 'MergedPods/RxFrameworkSwift'
  pod 'NetworkSwift', path: 'MergedPods/NetworkSwift'
  pod 'RxFrameworkSwift', path: 'MergedPods/RxFrameworkSwift'
end

target 'RxFramework' do
  use_modular_headers!
  project 'RxFramework/RxFramework.xcodeproj'

  pod 'RxFrameworkSwift', path: 'MergedPods/RxFrameworkSwift'
end

pre_install do |installer|
  installer.analysis_result.specifications.each do |specs|
    specs.swift_version = '5'
  end
end