//
//  FlipAnimation.swift
//  SwiftUIAnimationExamples
//
//  Created by Luan Nguyen on 27/12/2020.
//

import SwiftUI

struct FlipAnimation: View {
    @State private var animating = false
    @State private var isImageFlipped = false
    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            if isImageFlipped {
                Image("credit-card-back")
                    .cornerRadius(24)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    
            } else {
                Image("credit-card-front")
                    .cornerRadius(24)
            }
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        .onTapGesture {
            withAnimation(Animation.linear(duration: 0.3)) {
                self.animating.toggle()
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                if self.animating {
                    withAnimation(Animation.linear(duration: 0.01)) {
                        self.rotation += 3
                    }
                    if self.rotation == 90 || self.rotation == 270 {
                        self.isImageFlipped.toggle()
                    } else if self.rotation == 360 || self.rotation == 180 {
                        self.animating = false
                    }
                    
                    if self.rotation == 360 {
                        self.rotation = 0
                    }
                }
            }
        }
    }
}

#if DEBUG
struct FlipAnimation_Previews: PreviewProvider {
    static var previews: some View {
        FlipAnimation()
    }
}
#endif
