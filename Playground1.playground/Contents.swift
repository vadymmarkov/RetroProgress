// RetroProgress iOS Playground

import UIKit
import PlaygroundSupport
import RetroProgress

let progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 360, height: 30))
progressView.animateProgress(to: 0.9)

PlaygroundPage.current.liveView = progressView
