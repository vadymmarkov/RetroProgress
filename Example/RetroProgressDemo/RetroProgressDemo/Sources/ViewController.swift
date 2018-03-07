import UIKit
import RetroProgress

final class ViewController: UIViewController {
  private lazy var progressView = self.makeProgressView()
  private lazy var button: UIButton = self.makeButton()
  private let styleGuide = StyleGuide()

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = styleGuide.primaryColor
    view.addSubview(progressView)
    view.addSubview(button)

    button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    setupConstraints()
  }

  // MARK: - Action

  @objc private func handleButtonTap() {
    let progress: Float = progressView.progress == 0.8 ? 0.2 : 0.8
    progressView.animateProgress(to: progress)
  }

  // MARK: - Layout

  private func setupConstraints() {
    progressView.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false

    let constraints = [
      progressView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
      progressView.heightAnchor.constraint(equalTo: progressView.widthAnchor, multiplier: 0.12),
      progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

      button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    ]

    NSLayoutConstraint.activate(constraints)
  }
}

// MARK: - View factory

private extension ViewController {
  func makeProgressView() -> ProgressView {
    let progressView = ProgressView()
    progressView.fullProgressAnimationDuration = 3

    // The same as default ProgressView styles
    progressView.progressInset = .init(top: 8, left: 8, bottom: 8, right: 8)
    progressView.layer.borderColor = styleGuide.progressColor.cgColor
    progressView.trackColor = styleGuide.primaryColor
    progressView.progressColor = styleGuide.progressColor
    progressView.separatorColor = styleGuide.primaryColor

    return progressView
  }

  func makeButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle("Animate!".uppercased(), for: .normal)
    button.setTitleColor(styleGuide.buttonColor, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    return button
  }
}

// MARK - Styles

private struct StyleGuide {
  let primaryColor = UIColor(red: 11/255, green: 36/255, blue: 251/255, alpha: 1)
  let progressColor = UIColor.white
  let buttonColor = UIColor.red
}
