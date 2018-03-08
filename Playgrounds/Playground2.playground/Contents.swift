// RetroProgress iOS Playground

import UIKit
import PlaygroundSupport
import RetroProgress

let progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 360, height: 30))

// Configure
progressView.layer.cornerRadius = 10
progressView.layer.borderColor = UIColor.black.cgColor
progressView.trackColor = .white
progressView.separatorColor = .black
progressView.progressColor = UIColor(
  red: 218/255,
  green: 236/255,
  blue: 255/255,
  alpha: 1
)

// Set progress
progressView.animateProgress(to: 0.9, duration: 5)

PlaygroundPage.current.liveView = progressView
