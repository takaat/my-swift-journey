//
//  TransferFundsScreen.swift
//  BankApp
//
//  Created by Mohammad Azam on 8/15/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct TransferFundsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var transferFundsVM = TransferFundsViewModel()
    @State private var showSheet = false
    @State private var isFromAccount = false
    
    var actionSheetButtons: [Alert.Button] {
        
        var actionButtons = self.transferFundsVM.filteredAccounts.map { account in
            Alert.Button.default(Text("\(account.name) (\(account.accountType))")) {
                if self.isFromAccount {
                    self.transferFundsVM.fromAccount = account
                } else {
                    self.transferFundsVM.toAccount = account
                }
            }
        }
        
        actionButtons.append(.cancel())
        return actionButtons
    }
    
    var body: some View {
        
        ScrollView {
        
        VStack {
            AccountListView(accounts: self.transferFundsVM.accounts)
                .frame(height: 200)
            
            TransferFundsAccountSelectionView(transferFundsVM: self.transferFundsVM, showSheet: $showSheet, isFromAccount: $isFromAccount)
                Spacer()
                .onAppear {
                    self.transferFundsVM.populateAccounts()
            }
        
            Text(self.transferFundsVM.message ?? "")
            
            Button("Submit Transfer") {
                self.transferFundsVM.submitTransfer {
                    // dismiss the model
                    self.presentationMode.wrappedValue.dismiss()
                }
            }.padding()
            
                .actionSheet(isPresented: $showSheet) {
                    ActionSheet(title: Text("Transfer Funds"), message: Text("Choose an account"), buttons: self.actionSheetButtons)
            }
            
            }
        }
        
        
        .navigationBarTitle("Transfer Funds").embedInNavigationView()
    }
}

struct TransferFundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransferFundsScreen()
    }
}

