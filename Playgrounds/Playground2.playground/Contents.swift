// RetroProgress iOS Playground

import UIKit
import PlaygroundSupport
import RetroProgress

let progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 360, height: 30))

// Configure
progressView.progressInset = .init(top: 4, left: 4, bottom: 4, right: 4)
progressView.layer.cornerRadius = 0
progressView.layer.borderColor = UIColor.white.cgColor
progressView.trackColor = .black
progressView.progressColor = .white
progressView.separatorColor = .black

// Set progress
progressView.animateProgress(to: 0.9, duration: 5)

PlaygroundPage.current.liveView = progressView
