Pod::Spec.new do |s|
  s.name             = 'AMPopover'
  s.version          = '1.0.0'
  s.summary          = 'A simple and customizable iOS popover component with automatic position adjustment and arrow pointing.'
  s.description      = <<-DESC
AMPopover is a simple and customizable iOS popover component that supports automatic position adjustment and arrow pointing. It intelligently calculates the optimal display position based on the anchor view, ensuring the popover always stays within screen bounds.
                       DESC

  s.homepage         = 'https://github.com/owlivendy/AMPopover'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'owlivendy' => 'owlivendy@gmail.com' }
  s.source           = { :git => 'https://github.com/owlivendy/AMPopover.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'

  s.source_files = 'Sources/AMPopover/**/*'
end 