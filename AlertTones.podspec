Pod::Spec.new do |s|
  s.name             = 'AlertTones'
  s.version          = '1.0.0'
  s.summary          = 'iOS AlertTones framework'
  s.homepage         = 'https://github.com/sirnacnud/AlertTones'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Duncan Cunningham'
  s.source           = { :git => 'https://github.com/sirnacnud/AlertTones.git', :tag => s.version.to_s }
  s.swift_version    = '5.0' 
  s.default_subspec  = 'UI'
  
  s.ios.deployment_target = '11.0'

  s.subspec "Core" do |spec|
    spec.source_files = 'AlertTones/Classes/Core/**/*'
  end

  s.subspec "UI" do |spec|
    spec.source_files = 'AlertTones/Classes/UI/**/*'
    spec.resource_bundle = { 'AlertTones': 'AlertTones/Assets/**/*'}
    spec.dependency 'AlertTones/Core'
  end
end
