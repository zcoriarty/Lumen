//
//  Leaderboard.swift
//  Lumen
//
//  Created by Zachary Coriarty on 6/24/23.
//


import SwiftUI

struct User: Identifiable {
    let id = UUID()
    let name: String
    let profileImage: String
    let rentSaved: Double
    let streak: Int
}


struct Leaderboard: View {
    
    let users: [User]
    let maxRentSaved: Double
    @State private var isShowingExplanation = false
    
    init(users: [User]) {
        self.users = users
        if let maxSaved = users.max(by: { $0.rentSaved < $1.rentSaved }) {
            self.maxRentSaved = maxSaved.rentSaved
        } else {
            self.maxRentSaved = 1
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            HStack{
                VStack(alignment: .leading){
                    Text("NYC Leaderboard")
                        .font(.system(size: 30, weight: .semibold))
                    Text("Possible Rewards: $3000")
                        .font(.system(size: 20, weight: .light))
                }
                
                Spacer()
                
                Button(action: {
                    isShowingExplanation = true
                }) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                }
                .font(.title)
                .padding(.trailing)
                .sheet(isPresented: $isShowingExplanation) {
                    VStack(alignment: .leading){
                        Text("Leaderboard")
                            .font(.system(size: 35, weight: .heavy))
                            .padding(.bottom)
                        Text("Users can earn money off their rent by continuously using a below average energy usage, per person, for NYC.")
                            .font(.title3)
//                            .padding(.bottom)
                        Text("The higher a users streak the more they're able to earn!")
                            .font(.title3)
                        Spacer()
                        Text("A function of diminishing returnsis used: y = a*sqrt(x). Meaningyour returns decelerate as you earn, but you're always earning more!")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.yellow.opacity(0.4)) // Change the background color to your desired color
//                    .padding()
                    .presentationDetents([.height(300)])
                    
                        
                }
                
            }
            
            ForEach(users) { user in
                ZStack {
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color.yellow.opacity(0.2))
                            Rectangle()
                                .frame(width: CGFloat(user.rentSaved / 100) * geometry.size.width)
                                .foregroundColor(Color(hex: "#FFE800"))
                        }
                    }
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.25))
                                .frame(width: 40, height: 40) // Decreased size
                            Text(user.profileImage)
                                .font(.system(size: 20)) // Decreased size
                        }
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline) // Adjusted size
                        }

                        Spacer()
                        VStack {
                            Text("Streak: \(user.streak)")
                                .font(.system(size: 15, weight: .regular)) // Adjusted size
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .padding(.horizontal, 10) // Decreased padding
                    .padding(.vertical, 2) // Decreased padding
                }
                .background(Color.white)
                .cornerRadius(10)
                .padding(.vertical, 2) // Decreased padding
                .frame(height: 60)

            }
        }
        .padding()
    }
}

struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        let users = [
            User(name: "Zach Coriarty", profileImage: "😀", rentSaved: 10 * sqrt(8), streak: 8),
            User(name: "Joe Smith", profileImage: "😄", rentSaved: 10 * sqrt(7), streak: 7),
            User(name: "Vanessa Abbey", profileImage: "😀", rentSaved: 10 * sqrt(7), streak: 7),
            User(name: "Taylor Swift", profileImage: "😀", rentSaved: 10 * sqrt(6), streak: 6),
            User(name: "Beyonce Knowles", profileImage: "😄", rentSaved: 10 * sqrt(5), streak: 5),
            User(name: "Madhu Sriram", profileImage: "😄", rentSaved: 10 * sqrt(5), streak: 5),
            User(name: "Ariana Grande", profileImage: "😀", rentSaved: 10 * sqrt(4), streak: 4),
            User(name: "Alan Robinson", profileImage: "😀", rentSaved: 10 * sqrt(4), streak: 4),
            User(name: "Kim Kardashian", profileImage: "😄", rentSaved: 10 * sqrt(4), streak: 4),
            User(name: "Will Smith", profileImage: "😀", rentSaved: 10 * sqrt(3), streak: 3),
            User(name: "Justin Bieber", profileImage: "😄", rentSaved: 10 * sqrt(3), streak: 3),
            User(name: "Billie Eilish", profileImage: "😀", rentSaved: 10 * sqrt(2), streak: 2),
            User(name: "Ed Sheeran", profileImage: "😄", rentSaved: 10 * sqrt(1), streak: 1),
            User(name: "Rocky Balboa", profileImage: "😄", rentSaved: 10 * sqrt(1), streak: 1),
            User(name: "John Doe", profileImage: "😄", rentSaved: 10 * sqrt(0), streak: 0),
            User(name: "Natalie Portman", profileImage: "☹️", rentSaved: 10 * sqrt(0), streak: 0),
            User(name: "Dwayne Johnson", profileImage: "☹️", rentSaved: 10 * sqrt(0), streak: 0),
            User(name: "William Lou", profileImage: "☹️", rentSaved: 10 * sqrt(0), streak: 0),
            User(name: "Lindsey Liu", profileImage: "☹️", rentSaved: 10 * sqrt(0), streak: 0),
            User(name: "Harry Styles", profileImage: "☹️", rentSaved: 10 * sqrt(0), streak: 0),
            User(name: "Rihanna Fenty", profileImage: "☹️", rentSaved: 10 * sqrt(0), streak: 0),
            User(name: "Katy Perry", profileImage: "☹️", rentSaved: 10 * sqrt(0), streak: 0),
            User(name: "Bruno Mars", profileImage: "☹️", rentSaved: 10 * sqrt(0), streak: 0),
            User(name: "Lady Gaga", profileImage: "☹️", rentSaved: 10 * sqrt(0), streak: 0),
            User(name: "Adele Adkins", profileImage: "☹️", rentSaved: 10 * sqrt(0), streak: 0)

        ]
        Leaderboard(users: users)
    }
}
