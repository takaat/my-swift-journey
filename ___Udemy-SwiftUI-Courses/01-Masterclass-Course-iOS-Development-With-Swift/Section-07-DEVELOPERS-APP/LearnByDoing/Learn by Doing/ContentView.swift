import SwiftUI

struct ContentView: View {
  // MARK: - PROPERTIES
  var cards: [Card] = cardData
  
  // MARK: - CONTENT
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .center, spacing: 20) {
        ForEach(cards) { item in
          CardView(card: item)
        }
      }
      .padding(20)
    }
  }
}

// MARK: - PREVIEW
#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(cards: cardData)
      .previewDevice("iPhone 12 Pro Max")
  }
}
#endif
