//
//  Home.swift
//  TranslucentBackgroundEffect
//
//  Created by Luan Nguyen on 18/12/2020.
//

import SwiftUI

struct Home: View {
    // MARK: - PROPERTIES
    @State var search = ""
    @State var index = 0
    @State var tabIndex = 1
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                //: BLURING THE VIEW
                .blur(radius: 35,opaque: true)
            
            //: SCROLLVIEW
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        HStack {
                            Button(action: {}, label: {
                                Image("menu")
                                    .renderingMode(.original)
                            })
                            
                            Spacer()
                            
                            Image("pic")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        } //: HSTACK
                        .padding(.all)
                        
                        HStack {
                            Text("Find Your\nFavourite Clothes")
                                .font(.system(size: 30))
                                .foregroundColor(.black)
                            
                            Spacer(minLength: 0)
                        } //: HSTACK
                        .padding(.horizontal)
                        
                        HStack(spacing: 25) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 22))
                                .foregroundColor(.black)
                            
                            VStack(alignment: .leading) {
                                TextField("Search", text: $search)
                                
                                Divider()
                                    .background(Color.black)
                            } //: VSTACK
                        } //: HSTACK
                        .padding(.vertical)
                        .padding(.horizontal)
                        
                        //: MENU
                        HStack(spacing: 15) {
                            ForEach(0..<menu.count,id: \.self) { i in
                                Button(action: {
                                    index = i
                                }, label: {
                                    VStack(spacing: 8) {
                                        Text(menu[i])
                                            .foregroundColor(.black)
                                            .fontWeight(index == i ? .bold : .none)
                                            .font(.system(size: 14))
                                        
                                        Circle()
                                            .fill(Color.black)
                                            .frame(width: 6, height: 6)
                                            .opacity(index == i ? 1 : 0)
                                    } //: VSTACK
                                    .padding(.vertical)
                                })
                            }
                        } //: HSTACK
                        .padding(.top, 10)
                        
                        //: ROW VIEW
                        HStack(spacing: 15) {
                            VStack(alignment: .leading,spacing: 10) {
                                ZStack {
                                    BlurView(style: .regular)
                                    
                                    Image("p1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                    VStack {
                                        HStack {
                                            Button(action: {}, label: {
                                                Image(systemName: "suit.heart.fill")
                                                    .foregroundColor(.red)
                                                    .padding(.all, 10)
                                                    .background(Color.white)
                                                    .clipShape(Circle())
                                            })
                                            
                                            Spacer()
                                        } //: HSTACK
                                        Spacer()
                                    } //: VSTACK
                                    .padding(.all, 10)
                                } //: ZSTACK
                                //: DYNAMIC FRAME
                                //: PADDING 30 + SPACING 15 = 45
                                .frame(width: (UIScreen.main.bounds.width - 45) / 2, height: 250)
                                .cornerRadius(15)
                                
                                Text("Summer Top")
                                    .font(.system(size: 14))
                                
                                Text("$129")
                                    .fontWeight(.bold)
                            } //: VSTACK
                            
                            VStack(alignment: .leading,spacing: 10) {
                                ZStack {
                                    BlurView(style: .regular)
                                    
                                    Image("p2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .rotationEffect(.init(degrees: 5))
                                    
                                    //: LIKE BUTTON
                                    VStack {
                                        HStack {
                                            Button(action: {}, label: {
                                                Image(systemName: "suit.heart.fill")
                                                    .foregroundColor(.red)
                                                    .padding(.all, 10)
                                                    .background(Color.white)
                                                    .clipShape(Circle())
                                            })

                                            Spacer()
                                        } //: HSTACK

                                        Spacer()
                                    } //: VSTACK
                                    .padding(.all, 10)
                                } //: ZSTACK
                                //: DYNAMIC FRAME
                                //: PADDING 30 + SPACING 15 = 45
                                .frame(width: (UIScreen.main.bounds.width - 45) / 2, height: 250)
                                .cornerRadius(15)
                                
                                Text("Trend Top")
                                    .font(.system(size: 14))
                                
                                Text("$159")
                                    .fontWeight(.bold)
                            } //: VSTACK
                        } //: HSTACK
                        .padding(.all)
                        
                        HStack {
                            Text("New Collections")
                                .font(.system(size: 22))
                                .foregroundColor(.black)
                            
                            Spacer()
                        } //: HSTACK
                        .padding(.horizontal)
                        .padding(.top,10)
                        
                        ZStack {
                            BlurView(style: .regular)
                            
                            HStack {
                                VStack(alignment: .leading,spacing: 10) {
                                    Text("Causal Top")
                                        .foregroundColor(.black)
                                    
                                    Text("$299")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                    
                                    Button(action: {}, label: {
                                        Text("Try Now")
                                            .foregroundColor(.black)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 20)
                                            .background(Color.white)
                                            .clipShape(Capsule())
                                    })
                                    .padding(.top, 10)
                                } //: VSTACK
                                Image("p3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } //: HSTACK
                            
                            VStack {
                                HStack {
                                    Button(action: {}, label: {
                                        Image(systemName: "suit.heart.fill")
                                            .foregroundColor(.red)
                                            .padding(.all, 10)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                    })
                                    Spacer()
                                } //: HSTACK
                                Spacer()
                            } //: VSTACK
                            .padding(.all, 10)
                        } //: ZSTACK
                        .frame(height: 250)
                        .cornerRadius(15)
                        .padding(.all)
                        
                        Spacer()
                    } //: VSTACK
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .padding(.bottom)
                }) //: SCROLLVIEW
                
                //: TAB VIEW
                HStack(spacing: 0) {
                    Button(action: {
                        tabIndex = 0
                    }, label: {
                        Image(systemName: "suit.heart.fill")
                            .font(.system(size: 20))
                            .foregroundColor(tabIndex == 0 ? .white : Color("Color"))
                            .padding(.all)
                            .background(Color("Color").opacity(tabIndex == 0 ? 1 : 0))
                            .clipShape(Circle())
                    })
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        tabIndex = 1
                    }, label: {
                        Image(systemName: "house.fill")
                            .font(.system(size: 20))
                            .foregroundColor(tabIndex == 1 ? .white : Color("Color"))
                            .padding(.all)
                            .background(Color("Color").opacity(tabIndex == 1 ? 1 : 0))
                            .clipShape(Circle())
                    })
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        tabIndex = 2
                    }, label: {
                        Image(systemName: "cart.fill")
                            .font(.system(size: 20))
                            .foregroundColor(tabIndex == 2 ? .white : Color("Color"))
                            .padding(.all)
                            .background(Color("Color").opacity(tabIndex == 2 ? 1 : 0))
                            .clipShape(Circle())
                    })
                } //: HSTACK
                .padding(.top)
                .padding(.horizontal)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                .background(BlurView(style: .regular))
                .clipShape(CShape())
                .shadow(radius: 4)
            } //: VSTACK
        } //: ZSTACK
        .edgesIgnoringSafeArea(.all)
    }
}

var menu = ["New", "Popular", "Trending", "Highlights", "Medium"]
