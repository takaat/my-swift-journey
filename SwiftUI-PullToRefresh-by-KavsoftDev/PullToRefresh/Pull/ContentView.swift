import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @State var arrayData = ["Hello Data 1","Hello Data 2","Hello Data 3","Hello Data 4","Hello Data 5"]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Pull To Refresh")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.orange)
                
                Spacer()
            }
            .padding()
            .background(Color.white.ignoresSafeArea(.all, edges: .top))
            
            Divider()
            
            KRefreshScrollView(progressTint: .orange, arrowTint: .orange) {
                VStack {
                    ForEach(arrayData,id: \.self) { value in
                        HStack {
                            Text(value)
                            Spacer()
                        }
                        .padding()
                    }
                }
                .background(Color.white)
                .padding()
            } onUpdate: {
                arrayData.append("New Data")
            }
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea())
    }
}
