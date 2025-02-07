import SwiftUI

struct Nagivation: View {
    var body: some View {
        Text("Hello, World!")
    }
}

var NavigationMacOS: some View {
    NavigationView {
        List(Menu) { m in
            NavigationLink(
                destination: Text(m.name)) {
                Label(m.name, systemImage: m.icon)
            }
        }
        .listStyle(SidebarListStyle())
    }
    .navigationTitle("macOS Navigation")
}

struct Nagivation_Previews: PreviewProvider {
    static var previews: some View {
        Nagivation()
    }
}
