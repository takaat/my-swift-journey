//
//  SignUpForm.swift
//  SwiftUI-Gallery
//
//  Created by Luan Nguyen on 16/01/2021.
//

import SwiftUI

struct SignUpForm: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""

    var accentColor: Color = Color.blue
    var grayBackground: Color = Color.gray.opacity(0.2)

    var body: some View {
        VStack{
            Text("Sign Up")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            TextField("Username", text: $username)
                .padding()
                .background(grayBackground)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $password)
                .padding()
                .background(grayBackground)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            TextField("Email", text: $email)
                .padding()
                .background(grayBackground)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            Button(action: {

            }){
                Text("Sign Up!")
                 .font(.headline)
                 .foregroundColor(.white)
                 .padding()
                 .frame(width: 220, height: 60)
                 .background(accentColor)
                 .cornerRadius(15.0)
            }
        }
        .padding()
    }
}

struct SignUpForm_Previews: PreviewProvider {
    static var previews: some View {
        SignUpForm()
    }
}
