Pod::Spec.new do |s|
  s.name             = "RetroProgress"
  s.summary          = "Retro looking progress bar straight from the 90s"
  s.version          = "1.0.0"
  s.homepage         = "https://github.com/vadymmarkov/RetroProgress"
  s.license          = 'MIT'
  s.author           = {
    "Vadym Markov" => "markov.vadym@gmail.com"
  }
  s.source           = {
    :git => "https://github.com/vadymmarkov/RetroProgress.git",
    :tag => s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/vadymmarkov'

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.2'

  s.requires_arc = true
  s.ios.source_files = 'Sources/**/*'
  s.tvos.source_files = 'Sources/**/*'

  s.ios.frameworks = 'UIKit'
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '4.0'
  }
end
