//
//  Home.swift
//  SwiftUIVPNApp
//
//  Created by Luan Nguyen on 25/12/2020.
//

import SwiftUI

struct Home: View {
    @State var selected = servers.first!
    @State var isServerOn = false
    @State var isSmall = UIScreen.main.bounds.height < 750
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print("Button Pressed!")
                }, label: {
                    Image(systemName: "circle.grid.cross")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.5), lineWidth: 0.5))
                })
                
                Spacer()
                
                Button(action: {
                    print("Button Pressed!")
                }, label: {
                    HStack {
                        Image(systemName: "crown.fill")
                            .foregroundColor(.yellow)
                        Text("Go Premium")
                            .fontWeight(.heavy)
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.vertical,10)
                    .background(Color.black.opacity(0.2))
                    .clipShape(Capsule())
                })
            }
            .padding()
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 15) {
                    ForEach(servers) { server in
                        Image(server.flag)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                            .onTapGesture {
                                withAnimation{selected = server}
                            }
                            .padding(5)
                            .background(Circle().stroke(Color.white.opacity(selected.id == server.id ? 1 : 0), lineWidth: 1))
                    }
                }
                .padding()
            })
            
            ZStack {
                Image("world")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width - 40)
                
                VStack(spacing: 10) {
                    if isServerOn {
                        Text(selected.name)
                            .fontWeight(.semibold)
                    }
                    
                    Text(isServerOn ? "Connected" : "Not Connected")
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    if isServerOn {
                        HStack {
                            Image(selected.flag)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                            
                            Text("222.444.555.67")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                    }
                }
                .offset(y: -20)
            }
            .padding(.vertical,isSmall ? 0 : 25)
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: isServerOn ? .bottom : .top), content: {
                Capsule()
                    .fill(Color(isServerOn ? "dragbg1" : "dragbg2"))
                
                VStack {
                    if !isServerOn {
                        Spacer()
                    }
                    
                    Image(systemName: "chevron.\(isServerOn ? "up" : "down")")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    
                    Image(systemName: "chevron.\(isServerOn ? "up" : "down")")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    if isServerOn {
                        Spacer()
                    }
                }
                .offset(y: isServerOn ? 30 : -30)
                
                ZStack {
                    Capsule()
                        .fill(Color(isServerOn ? "drag2" : "drag1"))
                        .frame(height: 180)
                        .padding(10)
                    
                    VStack(spacing: 16) {
                        Capsule()
                            .fill(isServerOn ? Color.black.opacity(0.45) : Color.green)
                            .frame(width: 30, height: 8)
                        
                        Text( isServerOn ? "STOP" : "START")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        
                        Image(systemName: "power")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.25))
                            .clipShape(Circle())
                    }
                }
                .onTapGesture {
                    withAnimation{isServerOn.toggle()}
                }
            })
            .padding(.bottom, isSmall ? 5 : 15)
            .frame(width: 130)
            .background(
                ZStack {
                    Rings(width: UIScreen.main.bounds.width / 2, isServerOn: $isServerOn)
                        .offset(y: 70)

                    Rings(width: UIScreen.main.bounds.width / 1.6, isServerOn: $isServerOn)
                        .offset(y: 80)

                    Rings(width: UIScreen.main.bounds.width / 1.3, isServerOn: $isServerOn)
                        .offset(y: 90)

                    Rings(width: UIScreen.main.bounds.width / 1.1, isServerOn: $isServerOn)
                        .offset(y: 100)

                    Rings(width: UIScreen.main.bounds.width, isServerOn: $isServerOn)
                        .offset(y: 100)
                }
            )
            .padding(.bottom, isSmall ? 10 : 60)
        }
        .background(
            LinearGradient(gradient: .init(colors: [Color(isServerOn ? "bg11" : "bg21"), Color(isServerOn ? "bg12" : "bg22")]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(.all, edges: .all)
                .animation(.easeIn)
        )
        .preferredColorScheme(.dark)
        .statusBar(hidden: true)
    }
}

func getSize(index: Int)->CGFloat {
    if index < 10 || index > 50 {
        return 3
    }
    if index >= 10 && index < 20 {
        return 4
    }
    if index >= 40 && index <= 50 {
        return 4
    }
    else{
        return 5
    }
}

#if DEBUG
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
#endif
