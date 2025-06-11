Pod::Spec.new do |s|
  s.name             = 'AMPopover'
  s.version          = '1.1.0'
  s.summary          = 'A simple and customizable iOS popover component with automatic position adjustment and arrow pointing.'
  s.description      = <<-DESC
AMPopover is a simple and customizable iOS popover component that provides automatic position adjustment and smart arrow pointing. It's perfect for displaying menus, tooltips, or any custom content in a popover style.
                       DESC

  s.homepage         = 'https://github.com/owlivendy/AMPopover'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'owlivendy' => 'owlivendy@gmail.com' }
  s.source           = { :git => 'https://github.com/owlivendy/AMPopover.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'

  s.source_files = 'Sources/AMPopover/**/*'
end 
