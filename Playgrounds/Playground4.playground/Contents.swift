// RetroProgress iOS Playground

import UIKit
import PlaygroundSupport
import RetroProgress

let progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 360, height: 30))

// Configure
progressView.numberOfSteps = 0
progressView.progressInset = .zero
progressView.layer.cornerRadius = 15
progressView.layer.borderColor = UIColor.white.cgColor
progressView.trackColor = .black
progressView.progressColor = .white

// Set progress
progressView.animateProgress(to: 0.9, duration: 4)

PlaygroundPage.current.liveView = progressView
