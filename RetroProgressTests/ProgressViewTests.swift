import XCTest
@testable import RetroProgress

final class ProgressViewTests: XCTestCase {
  private var progressView: ProgressView!

  // MARK: - Setup

  override func setUp() {
    super.setUp()
    progressView = ProgressView()
    progressView.numberOfSteps = 10
  }

  // MARK: - Steps

  func testStepGet() {
    progressView.progress = 0.5
    XCTAssertEqual(progressView.step, 5)
  }

  func testStepSet() {
    progressView.step = 5
    XCTAssertEqual(progressView.progress, 0.5)
  }

  func testStepSet_WhenLessThan0() {
    progressView.step = -1
    XCTAssertEqual(progressView.step, 0)
    XCTAssertEqual(progressView.progress, 0)
  }

  func testStepSet_WhenMoreThanNumberOfSteps() {
    progressView.step = 15
    XCTAssertEqual(progressView.step, 10)
    XCTAssertEqual(progressView.progress, 1)
  }

  // MARK: - Progress

  func testProgressGet() {
    progressView.step = 5
    XCTAssertEqual(progressView.progress, 0.5)
  }

  func testProgressSet() {
    progressView.progress = 0.5
    XCTAssertEqual(progressView.step, 5)
    XCTAssertEqual(progressView.progress, 0.5)
  }

  func testProgressSet_WhenLessThan0() {
    progressView.progress = -1
    XCTAssertEqual(progressView.step, 0)
    XCTAssertEqual(progressView.progress, 0)
  }

  func testProgressSet_WhenMoreThan1() {
    progressView.progress = 2
    XCTAssertEqual(progressView.step, 10)
    XCTAssertEqual(progressView.progress, 1)
  }

  // MARK: - Colors

  func testTrackColorGet() {
    progressView.layer.backgroundColor = UIColor.blue.cgColor
    XCTAssertEqual(progressView.trackColor, .blue)
  }

  func testTrackColorSet() {
    progressView.trackColor = .blue
    XCTAssertEqual(progressView.layer.backgroundColor, UIColor.blue.cgColor)
    XCTAssertEqual(progressView.trackColor, .blue)
  }

  // MARK: - Animations

  func testAnimateProgress() {
    progressView.progress = 0.2
    progressView.animateProgress(to: 0.8, duration: 0)
    XCTAssertEqual(progressView.progress, 0.8)
  }

  func testAnimateSteps() {
    progressView.step = 2
    progressView.animateSteps(to: 8, duration: 0)
    XCTAssertEqual(progressView.step, 8)
  }
}
