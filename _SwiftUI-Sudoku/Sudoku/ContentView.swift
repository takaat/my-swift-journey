import SwiftUI

struct ContentView: View {
    private let viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: viewModel.buttonsVSpacing) {
                Text("Sudoku Classic")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                HStack(spacing: viewModel.difficultyButtonHSpacing) {
                    ForEach(viewModel.difficultyLevels, id: \.self) { level in
                        NavigationLink(destination:
                            GameView(viewModel: GameViewModel(difficulty: level))
                                .environmentObject(SelectedCell())
                                .environmentObject(UserAction())
                                .environmentObject(EditState())
                                .environmentObject(StartingGridValues(grid: GridFactory.gridForDifficulty(level: level)))
                                .environmentObject(GridValues(grid: GridFactory.gridForDifficulty(level: level),
                                                              startingGrid: GridFactory.gridForDifficulty(level: level)))
                                .environmentObject(EditGridValues(grid: []))
                                .environmentObject(Difficulty(level: level))
                        ) {
                            Text(level.rawValue)
                                .font(.system(.headline, design: .rounded))
                        }
                        .menuButtonStyle()
                    }
                }
                NavigationLink(destination: SettingsView()) {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .font(.system(.headline, design: .rounded))
                .accentColor(Color("dynamicDarkGray"))
                
            }
            .fullBackgroundStyle()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewDevice(PreviewDevice(rawValue: "iPad (7th generation)"))
            .environment(\.colorScheme, .dark)
    }
}
