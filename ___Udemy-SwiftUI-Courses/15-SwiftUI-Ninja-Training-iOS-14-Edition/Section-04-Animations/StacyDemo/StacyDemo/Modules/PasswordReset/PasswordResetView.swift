//
//  PasswordResetView.swift
//  StacyDemo
//
//  Created by Kristijan Kralj on 03/12/2020.
//

import SwiftUI

struct PasswordResetView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @State private var email : String = ""
  @State private var showingAlert: Bool = false
  
  private func displayAlert() -> Alert {
    Alert(title: Text("Success"),
          message: Text("The email with the password reset instructions has been sent to your email."),
          dismissButton: .default(Text("Got it!"), action: {
            presentationMode.wrappedValue.dismiss()
          }))
  }
  
    var body: some View {
      ZStack {
        AnimatedWaveBackground()
        
        VStack {
          ScreenTitle("Forgot password?")
          Text("Please enter your email below to receive your password reset instructions.")
            .foregroundColor(.text)
            .padding(.horizontal,20)
          EmailField(email: $email)
            .padding(20)
          Button(action: { showingAlert.toggle() }) {
            Text("SEND REQUEST")
              .textStyle(GradientButtonStyle())
          }
          Spacer()
        }//vstack
        .alert(isPresented: $showingAlert) {
          displayAlert()
      }
      }
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView()
    }
}
