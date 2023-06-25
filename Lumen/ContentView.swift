//
//  MainView.swift
//  Lumen
//
//  Created by Zachary Coriarty on 6/24/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    let users = [
        User(name: "Zach Coriarty", profileImage: "😀", rentSaved: 40, streak: 8),
        User(name: "Joe Smith", profileImage: "😄", rentSaved: 15, streak: 7),
        User(name: "Vanessa Abbey", profileImage: "😀", rentSaved: 10, streak: 7),
        User(name: "Madhu Sriram", profileImage: "😄", rentSaved: 10, streak: 5),
        User(name: "Alan Robinson", profileImage: "😀", rentSaved: 10, streak: 4),
        User(name: "Kim Kardashian", profileImage: "😄", rentSaved: 5, streak: 4),
        User(name: "Will Smith", profileImage: "😀", rentSaved: 4, streak: 3),
        User(name: "Rocky Balboa", profileImage: "😄", rentSaved: 4, streak: 1),
        User(name: "John Doe", profileImage: "😄", rentSaved: 2, streak: 0),
        User(name: "Natalie Portman", profileImage: "☹️", rentSaved: 0, streak: 0),
        User(name: "Dwayne Johnson", profileImage: "☹️", rentSaved: 0, streak: 0),
        User(name: "William Lou", profileImage: "☹️", rentSaved: 0, streak: 0),
        User(name: "Lindsey Liu", profileImage: "☹️", rentSaved: 0, streak: 0),
        User(name: "Harry Styles", profileImage: "☹️", rentSaved: 0, streak: 0),
    ]
    @State private var isSignupComplete = false
    @StateObject private var userStore = UserStore()


    var body: some View {
        NavigationView {
            VStack {
                if isSignupComplete {
                    SignupView(isSignupComplete: $isSignupComplete)
                        .environmentObject(userStore)
                        
                } else {
                    TabView(selection: $selection) {
                        Home(userStore: userStore)
                            .tabItem {
                                selection == 0 ? Image(systemName: "house.fill") : Image(systemName: "house")
                            }
                            .tag(0)

                        Leaderboard(users: users)
                            .tabItem {
                                selection == 1 ? Image(systemName: "chart.bar") : Image(systemName: "chart.bar.fill")
                            }
                            .tag(1)
                        
                        GroupView()
                            .tabItem {
                                selection == 2 ? Image(systemName: "person.2") : Image(systemName: "person.2.fill")
                            }
                            .tag(2)
                        Profile()
                            .tabItem {
                                selection == 3 ? Image(systemName: "person.2") : Image(systemName: "person.2.fill")
                            }
                            .tag(3)
                    }
                    .background(Color.primary)

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environmentObject(Order())
    }
}
