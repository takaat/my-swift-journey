import SwiftUI
import UIKit
import CoreHaptics

struct SymbolList: View {
    @ObservedObject var model: SymbolModel
    
    @State private var searchText = ""
    @State private var sortOrder: SortOrder = .defaultOrder
    @State private var showingDetails = false
    @State private var showingAudit = false
    
    private let layout = [GridItem(.adaptive(minimum: 100), alignment: .top)]
    private var pluralizer: String { filteredSymbols(searchText).count == 1 ? "" : "s" }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    searchBar
                    symbolsCount
                    symbolsGrid
                }
            }
            .navigationBarTitle("SF Symbols", displayMode: .automatic)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Picker(selection: $sortOrder, label: Text("Sort")) {
                            ForEach(SortOrder.allCases, id: \.self) { order in
                                Text(order.rawValue).tag(order)
                            }
                        }
                        Divider()
                        Button(action: { showingAudit = true }) {
                            Text("Run Audit...")
                        }
                    }
                    label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .navButtonStyle()
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showingDetails) {
            SymbolDetail(model: model) {
                showingDetails = false
            }
        }
        .background(EmptyView()
                        .sheet(isPresented: $showingAudit) {
                            AuditResult(model: model) {
                                showingAudit = false
                            }
                        })
    }
    
    // MARK: - Subviews
    private var searchBar: some View {
        HStack {
            TextField("Search", text: $searchText)
                .disableAutocorrection(true)
                .foregroundColor(Color.primary)
                .frame(height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    UIApplication.shared.windows.first?.endEditing(true)
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(Font.body.bold())
                        .imageScale(.large)
                        .foregroundColor(Color.primary)
                }
                .pressableButton()
            }
        }
        .padding(.horizontal)
    }
    
    private var symbolsCount: some View {
        HStack {
            Text("\(filteredSymbols(searchText).count) symbol\(pluralizer)")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
        }
    }
    
    private var symbolsGrid: some View {
        LazyVGrid(columns: layout, spacing: 16) {
            ForEach(filteredSymbols(searchText), id: \.self) { symbol in
                Button(action: { select(symbol) }) {
                    SymbolCell(symbol: symbol, isFocused: false)
                        .contextMenu {
                            Button(action: {
                                select(symbol)
                            }) {
                                Text("Enlarge")
                                Image(systemName: "arrow.up.left.and.arrow.down.right")
                            }
                        }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }

    // MARK: - Helpers
    private func filteredSymbols(_ searchText: String) -> [Symbol] {
        return model.symbols(for: sortOrder, filter: searchText)
    }
    
    private func select(_ symbol: Symbol) {
        UIApplication.shared.windows.first?.endEditing(true)
        model.select(symbol)
        hapticBump()
        showingDetails = true
    }
    
    private func hapticBump() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolList(model: SymbolModel())
    }
}
