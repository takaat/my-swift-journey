import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(white: 0.0)
            ScrollView(.horizontal) {
                HStack(spacing: 50) {
                    // Apple Inspired
                    DrawingTool.pen(color: .blue, width: 75, bandThickness: 10)
                    DrawingTool.marker(color: .purple, width: 75)
                    RulerIcon(length: 600)
                    // Moleskin Inspired
                    DrawingTool.chiselMarker(color: .yellow, width: 75)
                    DrawingTool.roundMarker(color: .green, width: 75)
                    DrawingTool.fineTipPen(color: .pink, width: 75)
                    DrawingTool.graphitePencil(color: .gray, width: 75)
                }
                .frame(height: 600)
                .padding()
                .offset(y: 200)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
