#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint keyboard_invoker.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'keyboard_invoker'
  s.version          = '1.0.0'
  s.summary          = 'A plugin that invokes keys on the host system.'
  s.description      = <<-DESC
A plugin that invokes keys on the host system.
                       DESC
  s.homepage         = 'https://github.com/KitsuneYokai/keyboard_invoker'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'KitsuneYokai@Kitsu-Team.dev' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
