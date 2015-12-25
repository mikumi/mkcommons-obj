# MKCommons

[![CI Status](http://img.shields.io/travis/Michael Kuck/MKCommons.svg?style=flat)](https://travis-ci.org/Michael Kuck/MKCommons)
[![Version](https://img.shields.io/cocoapods/v/MKCommons.svg?style=flat)](http://cocoapods.org/pods/MKCommons)
[![License](https://img.shields.io/cocoapods/l/MKCommons.svg?style=flat)](http://cocoapods.org/pods/MKCommons)
[![Platform](https://img.shields.io/cocoapods/p/MKCommons.svg?style=flat)](http://cocoapods.org/pods/MKCommons)

While I don't mind sharing the code, this is mostly a personal collecton of random stuff that I pretty often. You won't find much documentation or an overview here, and lots of the stuff is also pretty old. 

I want to extract the code that I need frequently into separate pods (as done with https://github.com/mikumi/MKLog for example), but well... you know how it works. One day ;-)

## Requirements

## Installation

MKCommons is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MKCommons"
```

## NOTES

If you want to use MKCommons in an App Extension, please add this build step to your podfile:

```
post_install do |installer_representation|
  installer_representation.project.targets.each do |target|
    if target.name.end_with? "MKCommons"
      target.build_configurations.each do |build_configuration|
        if build_configuration.build_settings['APPLICATION_EXTENSION_API_ONLY'] == 'YES'
          build_configuration.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = ['$(inherited)', 'MKCOMMONS_APP_EXTENSIONS=1']
        end
      end
    end
  end
end
```

## Author

Michael Kuck, me@michael-kuck.com

## License

MKCommons is available under the MIT license. See the LICENSE file for more info.
