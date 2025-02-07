import SwiftUI

// Shadow Modify
struct ShadowModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
        .shadow(color: Color.colorTransparentBlack, radius: 0, x: 0, y: 6)
    }
}

// Button Modify
struct ButtonModiFier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .accentColor(Color.white)
    }
}

// Score Number Modify
struct ScoreNumberModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .shadow(color: Color.colorTransparentBlack, radius: 0, x: 0, y: 3)
        .layoutPriority(1)
    }
}

// Score Container Modify
struct ScoreContainerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding(.vertical, 4)
        .padding(.horizontal, 16)
        .frame(minWidth: 128)
        .background(
            Capsule()
                .foregroundColor(.colorTransparentBlack)
        )
    }
}

// Image Modify
struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 140, idealWidth: 200, maxWidth: 220, minHeight: 130, idealHeight: 190, maxHeight: 200, alignment: .center)
            .modifier(ShadowModifier())
    }
}

// Bet Number Modify
struct BetNumberModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title, design: .rounded))
            .padding(.vertical, 5)
            .frame(width: 90)
            .shadow(color: Color.colorTransparentBlack, radius: 0, x: 0, y: 3)
    }
}

// Bet Capsule Modify
struct BetCapsuleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [
                        Color.colorPink,
                        Color.colorPurple
                    ]), startPoint: .top, endPoint: .bottom))
            )
            .padding(3)
            .background(
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [
                        Color.colorPink,
                        Color.colorPurple
                    ]),
                    startPoint: .bottom, endPoint: .top))
                    .modifier(ShadowModifier())
            )
    }
}

// Casino Chips Modify
struct CasinoChipsModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame( height: 64)
            .animation(.default)
            .modifier(ShadowModifier())
    }
}
