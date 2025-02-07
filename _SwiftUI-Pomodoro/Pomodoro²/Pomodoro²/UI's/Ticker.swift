import SwiftUI

struct Ticker: View {
    var body: some View {
        ZStack {
            Capsule()
            .frame(width: 4)
            .foregroundColor(Color("accent"))
            VStack{
                Spacer()
                Circle()
                    .frame(width: 12, height: 12)
                .foregroundColor(Color("accent"))
            }
        }
    }
}

struct Ticker_Previews: PreviewProvider {
    static var previews: some View {
        Ticker()
    }
}
