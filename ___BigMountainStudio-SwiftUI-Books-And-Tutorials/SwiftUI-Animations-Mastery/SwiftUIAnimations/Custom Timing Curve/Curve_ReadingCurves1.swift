//
//  Curve_ReadingCurves1.swift
//  SwiftUIAnimations
//
//  Created by Mark Moeykens on 1/17/20.
//  Copyright © 2020 Mark Moeykens. All rights reserved.
//

import SwiftUI

struct Curve_ReadingCurves1: View {
    @State private var change = false
    
    var body: some View {
        ZStack {
            Color("Background3").edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                TitleText("Custom Timing Curve")
                SubtitleText("Reading Curves")
                BannerText("Fast, Slow, Fast.", backColor: Color("Secondary3"), textColor: Color("Foreground3"))
                
                Image("ReadingCurves1")
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color("Tertiary3"))
                    .frame(width: 100, height: 100)
                    .offset(x: change ? 140 : -140, y: 0)
                    .animation(Animation.timingCurve(0.1, 0.7, 0.9, 0.3, duration: 1))
                
                Spacer()
                
                Button("Change") {
                    self.change.toggle()
                }
            }
            .font(.title)
            .accentColor(Color("Accent3"))
        }
    }
}

struct Curve_ReadingCurves1_Previews: PreviewProvider {
    static var previews: some View {
        Curve_ReadingCurves1()
    }
}
