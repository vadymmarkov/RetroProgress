import UIKit

@IBDesignable
public final class ProgressView: UIView {
  // MARK: - Public properties

  /// Maximum number of steps. Set to 0 to remove separators.
  @IBInspectable
  public var numberOfSteps: UInt = 10 {
    didSet {
      updateReplicatorLayer()
      layoutLayers()
    }
  }

  /// 0...numberOfSteps. Values outside are pinned.
  @IBInspectable
  public var step: Float {
    get {
      return Float(numberOfSteps) * progress
    }
    set {
      if numberOfSteps > 0 {
        progress = newValue / Float(numberOfSteps)
      }
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
  public var progressInset: UIEdgeInsets = .zero {
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

  // MARK: - Private layers

  private let replicatorLayer = CAReplicatorLayer()
  private let separatorLayer = CALayer()
  private let progressLayer = CALayer()

  // MARK: - Private properties

  private var progressValue: Float = 0.0 {
    didSet {
      progressLayer.removeAllAnimations()
      progressLayer.bounds.size.width = progressLayerWidth
    }
  }

  // MARK: - Init

  public override init(frame: CGRect) {
    super.init(frame: frame)
    layer.addSublayer(progressLayer)
    layer.addSublayer(replicatorLayer)
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
  /// - Parameter progress: Progress value
  /// - Parameter duration: Animation duration
  public func animateProgress(to progress: Float, duration: TimeInterval) {
    let currentWidth = progressLayer.frame.width
    progressValue = progress

    let layerAnimation = CABasicAnimation(keyPath: "bounds.size.width")
    layerAnimation.duration = duration
    layerAnimation.fromValue = currentWidth
    layerAnimation.toValue = progressLayer.frame.width

    progressLayer.add(layerAnimation, forKey: nil)
  }

  // MARK: - Layout

  public override func layoutSubviews() {
    super.layoutSubviews()
    layoutLayers()
  }

  private func layoutLayers() {
    let stepWidth = innerFrame.width / CGFloat(numberOfSteps)

    replicatorLayer.frame = innerFrame
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(stepWidth, 0, 0)

    separatorLayer.frame = CGRect(
      x: stepWidth,
      y: 0,
      width: 2,
      height: replicatorLayer.bounds.height
    )

    progressLayer.frame = CGRect(
      x: innerFrame.minX,
      y: innerFrame.minY,
      width: progressLayerWidth,
      height: innerFrame.height
    )
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
    backgroundColor = .white
    layer.masksToBounds = true
    layer.cornerRadius = 10
    layer.borderColor = UIColor.blue.cgColor
    layer.borderWidth = 2

    separatorLayer.backgroundColor = UIColor(white: 1, alpha: 0.5).cgColor

    progressLayer.position = .zero
    progressLayer.anchorPoint = .zero
    progressLayer.backgroundColor = UIColor.blue.cgColor
  }

  private func updateReplicatorLayer() {
    replicatorLayer.instanceCount = Int(numberOfSteps - 1)
  }
}
