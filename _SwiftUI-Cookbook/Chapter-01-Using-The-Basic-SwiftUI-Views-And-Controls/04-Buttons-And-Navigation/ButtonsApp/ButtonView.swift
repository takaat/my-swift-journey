//
//  ButtonView.swift
//  ButtonsApp
//
//  Created by Edgar Nzokwe on 3/4/20.
//  Copyright © 2020 Edgar Nzokwe. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    @State var count = 0
    var body: some View {
        VStack{
            Text("Welcome to your second view")
            Text("Current count value: \(count)")
                .padding()
            Button(action: {
               self.count += 1
            }){
               Text("Tap to Increment count")
               .fontWeight(.bold)
               .foregroundColor(Color.white)
               .padding()
               .background(Color.blue)
               .clipShape(Capsule())
                   
            }
            
        }.navigationBarTitle("Button View", displayMode: .inline)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
