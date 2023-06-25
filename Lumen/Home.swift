//
//  Home.swift
//  Lumen
//
//  Created by Zachary Coriarty on 6/24/23.
//

import SwiftUI
import Foundation

struct Home: View {
    
    @StateObject var userStore: UserStore

        
    var body: some View {
        VStack(alignment: .leading) {
            let greeting = getGreeting(for: Date())
            Text("\(greeting) \(userStore.currentUser?.name ?? "")")
                .font(.system(size: 30, weight: .semibold))
            Text("Your rent is 80% cheaper")
                .font(.system(size: 20, weight: .light))
                
            HomeAnimation()
            
        }
        .padding()
    
    }
    

    func getGreeting(for time: Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        
        if hour < 12 {
            return "Good Morning,"
        } else if hour < 18 {
            return "Good Afternoon,"
        } else {
            return "Good Evening,"
        }
    }

}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
