import SwiftUI

struct OnboardingView: View {
  var onboardingData: [OnboardingItem] = [
    OnboardingItem(imageName: "onb_find_place", title: "Find Places to Live", description: "Find great verified places & people to share the home with."),
    OnboardingItem(imageName: "onb_match", title: "Match Your Preferencs", description: "Tell us your preferences and match with the right people."),
    OnboardingItem(imageName: "onb_like", title: "Like-minded People", description: "Live together with people who will inspire like you.")
  ]
  
  var body: some View {
    VStack {
      TabView {
        ForEach(0 ..< onboardingData.count) { index in
          let element = onboardingData[index]
          OnboardingCard(onboardingItem: element)
        }
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
      .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
      
      Button(action: {}) {
        Text("GET STARTED")
          .frame(maxWidth: .infinity)
          .padding()
          .foregroundColor(.white)
          .background(LinearGradient(gradient: Gradient(colors: [Color.gradientStart, Color.gradientEnd]), startPoint: .leading, endPoint: .trailing))
          .cornerRadius(10)
          .padding(.horizontal, 20)
      }
      
      Button(action: { print("button tapped") }) {
        Text("Login")
          .padding()
          .foregroundColor(.text)
      }
    }
  }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
      OnboardingView()
    }
}

fileprivate struct OnboardingCard: View {
  let onboardingItem: OnboardingItem
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        Image(onboardingItem.imageName)
          .resizable()
          .frame(height: geometry.size.height / 1.5)
          .frame(maxWidth: .infinity)
        Text(onboardingItem.title)
          .font(.title)
          .foregroundColor(.title)
          .bold()
          .padding()
        Text(onboardingItem.description)
          .multilineTextAlignment(.center)
          .font(.body)
          .foregroundColor(.text)
          .padding(.horizontal, 15)
      }
    }
  }
}
