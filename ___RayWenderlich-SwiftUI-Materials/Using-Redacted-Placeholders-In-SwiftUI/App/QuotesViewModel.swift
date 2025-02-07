/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

final class QuotesViewModel: ObservableObject {
  @Published var isLoading = false
  @Published var quotes: [Quote] = []
  @Published var shouldConceal = false

  var shouldHideContent: Bool {
    return shouldConceal || isLoading
  }

  init() {
    beginObserving()

    isLoading = true
    let simulatedRequestDelay = Double.random(in: 1..<3)

    delay(interval: simulatedRequestDelay) {
      withAnimation {
        self.quotes = ModelLoader.bundledQuotes
      }

      let simulatedIngestionDelay = Double.random(in: 1..<3)

      self.delay(interval: simulatedIngestionDelay) {
        self.isLoading = false
      }
    }
  }

  private func delay(interval: TimeInterval, block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
      block()
    }
  }

  private func beginObserving() {
    let center = NotificationCenter.default
    center.addObserver(
      self,
      selector: #selector(appMovedToBackground),
      name: UIApplication.willResignActiveNotification,
      object: nil
    )
    center.addObserver(
      self,
      selector: #selector(appMovedToForeground),
      name: UIApplication.didBecomeActiveNotification,
      object: nil
    )
  }

  @objc private func appMovedToForeground() {
    shouldConceal = false
  }

  @objc private func appMovedToBackground() {
    shouldConceal = true
  }
}
