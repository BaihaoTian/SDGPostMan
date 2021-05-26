# coding: utf-8
#
# Be sure to run `pod lib lint SDGPostMan.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouragedSDGPostMan
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SDGPostMan'
  s.version      = "0.0.5"
  s.summary          = 'A short description of SDGPostMan.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'http://gitlab.51xianqu.com/xq_ios/sdgpostman'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'baihaotian@51xianqu.com' => 'baihaotian@51xianqu.net' }
  s.source           = { :git => 'git@gitlab.51xianqu.com:xq_ios/sdgpostman.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SDGPostMan/Classes/**/*'

 # s.resource_bundles = {
 #   'SDGPostMan' => ['SDGPostMan/Assets/*']
 # }

  s.prefix_header_contents = <<-EOS
  #ifdef __OBJC__
      #import "SDGPostMan.h"
  #endif
  EOS

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
