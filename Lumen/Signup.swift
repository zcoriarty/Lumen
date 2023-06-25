//
//  Signup.swift
//  Lumen
//
//  Created by Zachary Coriarty on 6/24/23.
//

import SwiftUI

struct CurrentUser {
    var name: String
    var zipCode: String
    var totalBets: Float
}

class UserStore: ObservableObject {
    @Published var currentUser: CurrentUser?

    func addBet(amount: Float) {
        currentUser?.totalBets += amount
    }
}

struct SignupView: View {
    @EnvironmentObject var userStore: UserStore
    @Binding var isSignupComplete: Bool // Add the binding
    
    @State private var name = ""
    @State private var zipCode = ""
    @State private var isNameValid = true
    @State private var isZipValid = true
    
    var body: some View {
        VStack {
            Text("Signup")
                .font(.system(size: 35, weight: .heavy))
            
            
            TextField("Name", text: $name)
                .padding()
                .onChange(of: name) { newValue in
                    isNameValid = !newValue.isEmpty
                }
                .border(isNameValid ? Color.gray : Color.red, width: 1)
                .cornerRadius(6)
            
            TextField("Address", text: $zipCode)
                .padding()
//                .onChange(of: zipCode) { newValue in
//                    isZipValid = newValue.count == 5 && newValue.allSatisfy({ $0.isNumber })
//                }
                .border(isZipValid ? Color.gray : Color.red, width: 1)
                .cornerRadius(6)
            
            Button(action: {
                guard isNameValid, isZipValid else { return }
                let user = CurrentUser(name: self.name, zipCode: self.zipCode, totalBets: 0.0)
                self.userStore.currentUser = user
                self.name = ""
                self.zipCode = ""
                self.isSignupComplete = true
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity) // Extend the button to the full width
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }.disabled(!isNameValid || !isZipValid) // Disable the button when inputs are not valid
        }
        .padding()
    }
}
