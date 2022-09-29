platform :ios, '13.0'
plugin 'cocoapods-pod-linkage'
plugin 'cocoapods-pod-merge'
plugin 'cocoapods-binary'

workspace 'MovieDB.xcworkspace'

# 3rd Party
def image_cache
  pod 'ImageCache', path: 'MergedPods/ImageCache', :binary => true
end

# MainApp
target 'MovieDB' do
end

## High level module
# Features
target 'MovieList' do
  use_frameworks! :linkage => :static

  project 'MovieList/MovieList.xcodeproj'
  image_cache

  target 'MovieListTests' do
    inherit! :search_paths
    image_cache
  end
end

target 'MovieDetail' do
  use_frameworks! :linkage => :static

  project 'MovieDetail/MovieDetail.xcodeproj'
  target 'MovieDetailTests' do
    inherit! :search_paths
  end
end

## Mid level module
# Bridge
target 'ModuleManagement' do
  use_frameworks! :linkage => :static

  project 'ModuleManagement/ModuleManagement.xcodeproj'
  target 'ModuleManagementTests' do
    inherit! :search_paths
  end 
end

## Low Level Module
# Core
target 'Core' do
  use_frameworks!

  project 'Core/Core.xcodeproj'
  target 'CoreTests' do
    inherit! :search_paths
  end
end

# UIKIt
target 'MovieKit' do
  use_frameworks! :linkage => :static

  project 'MovieKit/MovieKit.xcodeproj'  
  pod 'SnapKit'

  target 'MovieKitTests' do
    inherit! :search_paths
  end
end

# Network
target 'Networking' do
  use_frameworks! :linkage => :static

  project 'Networking/Networking.xcodeproj'

  image_cache
  pod 'Alamofire'

  target 'NetworkingTests' do
    inherit! :search_paths
    image_cache
  end
end

# 3rd party custom
target 'RxFramework' do
  use_frameworks! :linkage => :static

  project 'RxFramework/RxFramework.xcodeproj'

  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'
  pod 'NSObject+Rx', '5.2.1'
  pod 'RxDataSources', '~> 5.0'
end

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    
    target.build_configurations.each do |config|
      if config.name == 'Release'
        config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'RELEASE=1']
      elsif config.name == 'Debug'
        config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'DEBUG=1']
      end

      config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'

      config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
      # config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
  
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      # if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 13.0
      #   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      # end
      config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = '$(inherited)'

    end
  end
end

