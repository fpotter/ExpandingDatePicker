Pod::Spec.new do |s|
  s.name             = 'ExpandingDatePicker'
  s.version          = '1.0.1'
  s.summary          = 'A textual date picker that expands to show a graphical calendar view when focued.'

  s.description      = <<-DESC
ExpandingDatePicker is a textual date picker that will expand to show a
graphical date picker beneath it when focused.  It has the same styling
as the expandable date picker Apple uses in Calendar.app.
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
