import UIKit
import RetroProgress

final class ViewController: UIViewController {
  private lazy var progressView = self.makeProgressView()
  private lazy var button: UIButton = self.makeButton()

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "RetroProgress"

    view.backgroundColor = .white
    view.addSubview(progressView)
    view.addSubview(button)

    button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    setupConstraints()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    progressView.layer.cornerRadius = progressView.frame.height / 2
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
      progressView.heightAnchor.constraint(equalTo: progressView.widthAnchor, multiplier: 0.1),
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
    let progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 200, height: 20))

    progressView.fullProgressAnimationDuration = 3
    progressView.progressInset = .init(top: 4, left: 4, bottom: 4, right: 4)
    progressView.layer.borderColor = UIColor.black.cgColor
    progressView.trackColor = .white
    progressView.progressColor = UIColor(red: 218/255, green: 236/255, blue: 255/255, alpha: 1)
    progressView.separatorColor = .black

    return progressView
  }

  func makeButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle("Animate", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    return button
  }
}
