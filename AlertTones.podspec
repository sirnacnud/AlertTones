#
# Be sure to run `pod lib lint AlertTones.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AlertTones'
  s.version          = '1.0.0'
  s.summary          = 'iOS AlertTones framework'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Swift library to provide easy acess to the iOS provided Alert Tones.
                       DESC

  s.homepage         = 'https://github.com/sirnacnud/AlertTones'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Duncan Cunningham' => 'duncanc4@gmail.com' }
  s.source           = { :git => 'https://github.com/sirnacnud/AlertTones.git', :tag => s.version.to_s }
  s.swift_version    = '5.0' 
  s.default_subspec  = 'UI'
  s.ios.deployment_target = '9.0'

  s.subspec "Core" do |spec|
    spec.source_files = 'AlertTones/Classes/Core/**/*'
  end

  s.subspec "UI" do |spec|
    spec.source_files = 'AlertTones/Classes/UI/**/*'
    spec.resource_bundle = { 'AlertTones': 'AlertTones/Assets/**/*'}
    spec.dependency 'AlertTones/Core'
  end

end
