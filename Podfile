# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

use_frameworks!

def reactive_pods
  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'
  pod 'NSObject+Rx', '5.2.1'
end

def network_pods
  pod 'Alamofire', '5.4.3'
end

def layout_pods
  pod 'SnapKit', '5.0.1'
  pod 'Kingfisher', '~> 7.0'
end

def testing_pods
  pod 'RxBlocking', '6.2.0'
  pod 'RxTest', '6.2.0'
end

target 'MovieDB' do
  reactive_pods
  network_pods
  layout_pods
end
