# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'GithubPractice' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  pod 'Moya', '~> 14.0'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'Kingfisher', '~> 5.0'
  pod 'IQKeyboardManagerSwift'
  pod 'SnapKit', '~> 5.0.0'

  pod 'RxSwift', '< 6.0.0'
  pod 'RxCocoa', '< 6.0.0'
  pod 'RxDataSources', '< 5.0'
  pod 'NSObject+Rx'
  pod "RxGesture"
  pod 'RxViewController'

  target 'GithubPracticeTests' do
      inherit! :search_paths
      
      # Pods for testing
      pod 'Quick', '~> 3.0'
      pod 'Nimble', '~> 8.0'
      pod 'RxAtomic', :modular_headers => true
      pod 'RxBlocking'
  end
end
