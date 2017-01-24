Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.name = 'MGBottomSheet'
  s.summary = <<-DESC
              MGBottomSheet lets a user create a bottom sheet for select actions with material appearance.
              DESC
  s.requires_arc = true
  s.version = '1.0.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Guillermo Garcia Rebolo' => 'guillermogarcia_18@hotmail.com' }
  s.homepage = 'https://github.com/guille969/MGBottomSheet'
  s.source = { :git => 'https://github.com/guille969/MGBottomSheet.git', :tag => s.version.to_s}
  s.framework = 'UIKit'
  s.source_files = 'MGBottomSheet/MGBottomSheet/**/*.{swift}'
  s.resource_bundles = {
    'MGBottomSheet' => ['MGBottomSheet/MGBottomSheet/**/*.{storyboard,xib}']
  }
end