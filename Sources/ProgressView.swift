import UIKit

@IBDesignable
public final class ProgressView: UIView {
  // MARK: - Public properties

  /// Maximum number of steps. Set to 0 to remove separators.
  @IBInspectable
  public var numberOfSteps: UInt = 10 {
    didSet {
      replicatorLayer.isHidden = numberOfSteps == 0
      separatorLayer.isHidden = replicatorLayer.isHidden
      updateReplicatorLayer()
      layoutLayers()
    }
  }

  /// Number of separators (0...numberOfSteps). Values outside are pinned.
  @IBInspectable
  public var step: Float {
    get {
      return Float(numberOfSteps) * progress
    }
    set {
      progress = makeProgress(forStep: newValue)
    }
  }

  /// 0...1, default is 0. Values outside are pinned.
  @IBInspectable
  public var progress: Float {
    get {
      return progressValue
    }
    set {
      switch newValue {
      case 1...:
        progressValue = 1
      case ..<0:
        progressValue = 0
      default:
        progressValue = newValue
      }
    }
  }

  /// The inner inset for progress bar and separators.
  @IBInspectable
  public var progressInset: UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8) {
    didSet {
      layoutLayers()
    }
  }

  /// The color shown for the portion of the progress bar that is not filled.
  @IBInspectable
  public var trackColor: UIColor? {
    get {
      return layer.backgroundColor.map(UIColor.init)
    }
    set {
      layer.backgroundColor = newValue?.cgColor
      innerLayer.backgroundColor = newValue?.cgColor
    }
  }

  /// The color shown for the portion of the progress bar that is filled.
  @IBInspectable
  public var progressColor: UIColor? {
    get {
      return progressLayer.backgroundColor.map(UIColor.init)
    }
    set {
      progressLayer.backgroundColor = newValue?.cgColor
    }
  }

  /// The color used for the step separators.
  @IBInspectable
  public var separatorColor: UIColor? {
    get {
      return separatorLayer.backgroundColor.map(UIColor.init)
    }
    set {
      separatorLayer.backgroundColor = newValue?.cgColor
    }
  }


  /// The duration for progress animation from 0 to 1.
  @IBInspectable
  public var fullProgressAnimationDuration: TimeInterval = 0.8

  @IBInspectable
  /// The width of step separators.
  public var separatorWidth: CGFloat = 4

  // MARK: - Private layers

  private let replicatorLayer = CAReplicatorLayer()
  private let separatorLayer = CALayer()
  private let progressLayer = CALayer()
  private let innerLayer = CALayer()

  // MARK: - Private properties

  private var progressValue: Float = 0.0 {
    didSet {
      progressLayer.removeAllAnimations()
      progressLayer.bounds.size.width = progressLayerWidth
      updateInnerCornerRadius()
    }
  }

  // MARK: - Init

  public override init(frame: CGRect) {
    super.init(frame: frame)
    layer.addSublayer(innerLayer)
    layer.addSublayer(replicatorLayer)

    innerLayer.addSublayer(progressLayer)
    replicatorLayer.addSublayer(separatorLayer)

    setupLayers()
    updateReplicatorLayer()
    layoutLayers()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Animations

  /// Animates progress bar to the specified value.
  /// - Parameter progress: Progress value (0...1)
  /// - Parameter duration: Animation duration
  public func animateProgress(to progress: Float, duration: TimeInterval? = nil) {
    let currentWidth = progressLayer.frame.width
    progressValue = progress
    let newWidth = progressLayer.frame.width
    let animationDuration: TimeInterval

    if let duration = duration {
      animationDuration = duration
    } else {
      let delta = Double(abs(newWidth - currentWidth))
      animationDuration = delta * fullProgressAnimationDuration / Double(innerFrame.width)
    }

    let layerAnimation = CABasicAnimation(keyPath: "bounds.size.width")
    layerAnimation.duration = animationDuration
    layerAnimation.fromValue = currentWidth
    layerAnimation.toValue = progressLayer.frame.width

    progressLayer.add(layerAnimation, forKey: nil)
  }

  /// Animates progress bar to the specified value
  /// - Parameter step: Number of steps (0...numberOfSteps)
  /// - Parameter duration: Animation duration
  public func animateSteps(to step: Float, duration: TimeInterval? = nil) {
    animateProgress(to: makeProgress(forStep: step), duration: duration)
  }

  // MARK: - Layout

  public override func layoutSubviews() {
    super.layoutSubviews()
    layoutLayers()
  }

  private func layoutLayers() {
    if numberOfSteps > 0 {
      let stepWidth = innerFrame.width / CGFloat(numberOfSteps)

      replicatorLayer.frame = innerFrame
      replicatorLayer.instanceTransform = CATransform3DMakeTranslation(stepWidth, 0, 0)

      separatorLayer.frame = CGRect(
        x: stepWidth,
        y: 0,
        width: separatorWidth,
        height: replicatorLayer.bounds.height
      )
    }

    innerLayer.frame = innerFrame
    progressLayer.frame = innerLayer.bounds
    progressLayer.frame.size.width = progressLayerWidth
    updateInnerCornerRadius()
  }

  private var innerFrame: CGRect {
    return CGRect(
      x: progressInset.left,
      y: progressInset.top,
      width: bounds.width - progressInset.left - progressInset.right,
      height: bounds.height - progressInset.top - progressInset.bottom
    )
  }

  private var progressLayerWidth: CGFloat {
    return innerFrame.width * CGFloat(progressValue)
  }

  // MARK: - Setup

  private func setupLayers() {
    let primaryColor = UIColor(red: 11/255, green: 36/255, blue: 251/255, alpha: 1)
    let progressColor = UIColor.white

    layer.backgroundColor = primaryColor.cgColor
    layer.masksToBounds = true
    layer.borderColor = progressColor.cgColor
    layer.borderWidth = 4

    innerLayer.masksToBounds = true
    innerLayer.backgroundColor = primaryColor.cgColor

    separatorLayer.backgroundColor = primaryColor.cgColor

    progressLayer.position = .zero
    progressLayer.anchorPoint = .zero
    progressLayer.backgroundColor = progressColor.cgColor
  }

  // MARK: - Helpers

  private func updateReplicatorLayer() {
    guard numberOfSteps > 0 else {
      return
    }
    replicatorLayer.instanceCount = Int(numberOfSteps - 1)
  }

  private func updateInnerCornerRadius() {
    innerLayer.cornerRadius = innerLayer.frame.height * layer.cornerRadius / bounds.height
  }

  private func makeProgress(forStep step: Float) -> Float {
    guard numberOfSteps > 0 else {
      return 0
    }

    switch step {
    case Float(numberOfSteps)...:
      return Float(numberOfSteps)
    case ..<0:
      return 0
    default:
      return step / Float(numberOfSteps)
    }
  }
}
