Pod::Spec.new do |s|
  s.name             = 'AMPopover'
  s.version          = '1.0.0'
  s.summary          = 'A simple and customizable popover menu for iOS.'
  s.description      = <<-DESC
AMPopover is a simple and customizable popover menu for iOS. It provides a clean and easy-to-use interface for displaying popover menus with customizable items.
                       DESC

  s.homepage         = 'https://github.com/owlivendy/AMPopover'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'owlivendy' => 'owlivendy@gmail.com' }
  s.source           = { :git => 'https://github.com/owlivendy/AMPopover.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'Sources/AMPopover/*.swift'
end 