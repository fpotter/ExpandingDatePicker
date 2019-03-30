Pod::Spec.new do |s|
  s.name             = 'ExpandingDatePicker'
  s.version          = '0.1.0'
  s.summary          = 'NSDatePicker that behaves like the date picker in Calendar.app'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/fpotter/ExpandingDatePicker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Fred Potter' => 'fpotter@gmail.com' }
  s.source           = { :git => 'https://github.com/fpotter/ExpandingDatePicker.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/fpotter'

  s.platform = :osx
  s.osx.deployment_target = "10.10"
  s.swift_version = "5.0"

  s.source_files = 'ExpandingDatePicker/Classes/**/*'
end
