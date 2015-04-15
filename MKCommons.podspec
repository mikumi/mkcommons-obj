#
# Be sure to run `pod lib lint MKCommons.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MKCommons"
  s.version          = "1.12.0"
  s.summary          = "A collection of common utils"
  s.description      = <<-DESC
                       A collection of common utils
                       DESC
  s.homepage         = "https://github.com/mikumi/mkcommons-obj"
  s.license          = 'MIT'
  s.author           = { "Michael Kuck" => "me@michael-kuck.com" }
  s.source           = { :git => "https://github.com/mikumi/mkcommons-obj.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'MKCommons' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'PureLayout', '~> 2.0.5'
  s.dependency 'MKLog', '~> 0.1.1'
end
