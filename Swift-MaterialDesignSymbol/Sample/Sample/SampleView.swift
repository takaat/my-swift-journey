import SwiftUI
import MaterialDesignSymbol

@available(iOS 14.0.0, *)
struct SampleView: View {
    var body: some View {
        VStack {
            Image(materialDesignIcon: .work48px, size: 50)
            Image(materialDesignIcon: .album24px, size: 30, color: .green)
        }
    }
}

@available(iOS 14.0.0, *)
struct SampleView_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
    }
}
