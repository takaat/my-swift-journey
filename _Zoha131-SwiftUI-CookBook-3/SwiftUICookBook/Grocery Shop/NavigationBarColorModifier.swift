import SwiftUI

/*
 * Copied from: https://filipmolcik.com/navigationview-dynamic-background-color-in-swiftui/
 */

struct NavigationBarModifier: ViewModifier {
  var backgroundColor: UIColor?

  init( backgroundColor: UIColor?) {
    self.backgroundColor = backgroundColor
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithTransparentBackground()
    coloredAppearance.backgroundColor = .clear
    //coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    //coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    UINavigationBar.appearance().tintColor = .white
  }

  func body(content: Content) -> some View {
    ZStack{
      content
      VStack {
        GeometryReader { geometry in
          Color(self.backgroundColor ?? .clear)
            .frame(height: geometry.safeAreaInsets.top)
            .edgesIgnoringSafeArea(.top)
          Spacer()
        }
      }
    }
  }
}

extension View {
  func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
    self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
  }
}
