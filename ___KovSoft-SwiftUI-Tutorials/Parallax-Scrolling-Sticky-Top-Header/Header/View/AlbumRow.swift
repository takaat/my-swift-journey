import SwiftUI

struct AlbumRow: View {
    var album: Album
    @Binding var columns: [GridItem]
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(album.album_cover)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    // padding = 30 + spacing: 15 = 45
                    .frame(width: columns.count == 2 ? (UIScreen.main.bounds.width - 45) / 2 : 85, height: columns.count == 2 ? (UIScreen.main.bounds.width - 45) / 2 : 85)
                    .cornerRadius(16)
                
                if columns.count == 1 {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(album.album_name)
                            .fontWeight(.heavy)
                        
                        Text(album.album_author)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer(minLength: 0)
                    
                    // Menu Button
                    Button(action: {
                        print("Menu Pressed.")
                    }) {
                        Image("menu")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                }
            }
            
            if columns.count == 2 {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(album.album_name)
                            .fontWeight(.heavy)
                        
                        Text(album.album_author)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer(minLength: 16)
                    
                    // Menu Button
                    Button(action: {
                        print("Menu Pressed.")
                    }) {
                        Image("menu")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

