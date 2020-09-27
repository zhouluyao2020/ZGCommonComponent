#
# Be sure to run `pod lib lint ZGCommonComponent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZGCommonComponent'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ZGCommonComponent.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/zhouluyao2020/ZGCommonComponent'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '437001178@qq.com' => 'zly77153@offcn.com' }
  s.source           = { :git => 'https://github.com/zhouluyao2020/ZGCommonComponent.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

s.source_files = 'ZGCommonComponent/Classes/**/*'
  # s.subspec 'Const' do |s|
  #   s.source_files = 'ZGCommonComponent/Classes/Const/*.{h,m}'
  #   s.public_header_files = 'ZGCommonComponent/Classes/Const/*.h'
  # end
  
  # s.subspec 'Model' do |s|
  #   s.source_files = 'ZGCommonComponent/Classes/Model/*.{h,m}'
  #   s.public_header_files = 'ZGCommonComponent/Classes/Model/*.h'
  # end
  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'YYModel','~> 1.0.4'
  s.dependency 'Masonry', '~> 1.1.0'
  s.dependency 'DZNEmptyDataSet', '~> 1.8.1'
  s.dependency 'MJRefresh','3.1.15'
  s.dependency 'Reachability', '~> 3.2'
end
