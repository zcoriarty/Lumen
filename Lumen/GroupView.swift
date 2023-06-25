//
//  GroupView.swift
//  Lumen
//
//  Created by Zachary Coriarty on 6/24/23.
//

import SwiftUI
import UniformTypeIdentifiers
import Charts
import UIKit


struct Group {
    var id: Int
    var name: String
    var totalPot: Int
    var daysLeft: Int
    var userCount: Int
    var potHistory: [Int]
    var users: [UserDetail]
}

struct UserDetail {
    var id: Int
    var name: String
    var betAmount: Int
}
class GroupData: ObservableObject {
    @Published var groups: [Group] = [
        Group(id: 1, name: "Apartment Building", totalPot: 75, daysLeft: 2, userCount: 5, potHistory: [4500, 4600, 4700, 4800, 4900, 5000], users: [
            UserDetail(id: 1, name: "Room 1A", betAmount: 30),
            UserDetail(id: 2, name: "Room 1B", betAmount: 5),
            UserDetail(id: 3, name: "Room 2A", betAmount: 5),
            UserDetail(id: 4, name: "Room 2b", betAmount: 20),
            UserDetail(id: 5, name: "Room 3", betAmount: 15),]),
        Group(id: 2, name: "Startup Community", totalPot: 45, daysLeft: 6, userCount: 10, potHistory: [4500, 4600, 4700, 4800, 4900, 5000], users: [
            UserDetail(id: 1, name: "Zach", betAmount: 0),
            UserDetail(id: 2, name: "Sally", betAmount: 0),
            UserDetail(id: 3, name: "Joe", betAmount: 0),
            UserDetail(id: 4, name: "Louise", betAmount: 20),
            UserDetail(id: 5, name: "Sydney", betAmount: 5),
            UserDetail(id: 6, name: "Andrew", betAmount: 0),
            UserDetail(id: 7, name: "Tessa", betAmount: 5),
            UserDetail(id: 8, name: "Lin", betAmount: 5),
            UserDetail(id: 9, name: "Mario", betAmount: 2),
            UserDetail(id: 10, name: "Nav", betAmount: 3),]),


    ]
    @ObservedObject var userStore = UserStore()
    
    func addBet(groupId: Int, userId: Int, bet: Int) {
        if let groupIndex = groups.firstIndex(where: {$0.id == groupId}),
           let userIndex = groups[groupIndex].users.firstIndex(where: {$0.id == userId}) {
            groups[groupIndex].totalPot += bet
            groups[groupIndex].potHistory.append(groups[groupIndex].totalPot)
            groups[groupIndex].users[userIndex].betAmount += bet
            userStore.addBet(amount: Float(bet))
        }
    }
    
    init() {
        userStore.currentUser = CurrentUser(name: "Initial", zipCode: "00000", totalBets: 0)
    }
    var totalPossibleWinnings: Int {
        groups.reduce(0) { $0 + $1.totalPot }
    }


}


struct GroupView: View {
    @ObservedObject var groupData = GroupData()
    @State private var showingNewGroupView = false
    
    var body: some View {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Total Bets: $\(groupData.userStore.currentUser?.totalBets ?? 0, specifier: "%.2f")")
                        .font(.system(size: 20, weight: .light))
                        .padding(.bottom)
                    
                    ForEach(groupData.groups, id: \.id) { group in
                        NavigationLink(destination: GroupDetailView(group: group, groupData: groupData)) {
                            GroupRow(group: group)
                        }
                        .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
                
                Text("Total Pot Value: $\(groupData.totalPossibleWinnings)")
                    .font(.headline)
                    .padding()
            }
            .navigationTitle("Your Groups")
            .navigationBarItems(trailing: Button(action: {
                self.showingNewGroupView = true
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
            })
            .sheet(isPresented: $showingNewGroupView) {
                NewGroupView(isPresented: self.$showingNewGroupView, groupData: groupData)
                    .environmentObject(self.groupData)
                    .presentationDetents([.height(250)])
            }
    }
}

struct ActivityViewController: UIViewControllerRepresentable {

    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}


struct GroupRow: View {
    let group: Group
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(group.name)
                        .font(.system(size: 30, weight: .bold))
                    Text("$\(group.totalPot)")
                        .font(.system(size: 20, weight: .light))
                }
                Spacer()
            }
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(group.daysLeft) days remaining")
                    Text("\(group.userCount) users")
                }
            }
        }
        .padding()
        .background(Color(hex: "#FFE800"))
        .cornerRadius(10)
    }
}

struct GroupDetailView: View {
    let group: Group
    @ObservedObject var groupData: GroupData
    @State var showKeypad = false
    @State var betAmount: Int? = 0
    @State var activeUser: UserDetail? = nil
    @State private var showShareSheet = false
    @State private var items: [Any] = []


    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(group.users, id: \.id) { user in
                        UserRow(user: user, totalPot: group.totalPot)
                            .padding([.top, .horizontal])
                            .onTapGesture {
                                self.activeUser = user
                                self.showKeypad = true
                            }
                    }
                }
                .sheet(isPresented: $showKeypad) {
                    KeypadView(betAmount: $betAmount, onDismiss: {
                        self.showKeypad = false
                    }) {
                        if let bet = betAmount, let user = activeUser {
                            groupData.addBet(groupId: group.id, userId: user.id, bet: bet)
                        }
                        self.showKeypad = false
                    }
                    .padding()
                    .presentationDetents([.medium])
                }
                
            }
            .navigationTitle(group.name)
            .navigationBarItems(trailing: Button(action: {
                // prepare the items you want to share
                self.items = ["Share this content"]
                self.showShareSheet = true
            }) {
                Image(systemName: "square.and.arrow.up")
                    .padding()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
            }
            .sheet(isPresented: $showShareSheet) {
                ActivityViewController(activityItems: [URL(string: "https://www.lumen.com/ashGryKhy")!])
                    .presentationDetents([.medium])
            })

        }
    }
}

struct UserRow: View {
    let user: UserDetail
    let totalPot: Int
    
    var body: some View {
        HStack {
            VStack{
                HStack {
                    Text(user.name)
                        .font(.system(size: 30, weight: .bold))
                    Spacer()
                        
                    Text("$\(user.betAmount)")
                        .font(.system(size: 20, weight: .light))
                }
                    ProgressBar(value: user.betAmount, maxValue: totalPot)
                        .frame(height: 10)
                        .padding(.bottom)
            }
            
        }
        .padding()
        .background(Color(hex: "#FFE800"))
        .cornerRadius(10)
    }
}

struct ProgressBar: View {
    var value: Int
    var maxValue: Int
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let ratio = Double(value) / Double(maxValue)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .opacity(0.3)
                    .frame(width: width, height: 20)
                
                Rectangle()
                    .frame(width: CGFloat(ratio) * width, height: 20)
            }
            .cornerRadius(10)
        }
    }
}

struct KeypadView: View {
    @Binding var betAmount: Int?
    var onDismiss: ()->Void
    var onConfirm: ()->Void
    let keypadNumbers = [1, 3, 5, 10, 15, 20, 30, 50, 100]

    var body: some View {
        VStack {
            Text("$\(betAmount ?? 0)")
                .font(.system(size: 40, weight: .heavy))
            
            let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(keypadNumbers, id: \.self) { number in
                    Button("\(number)") {
                        betAmount = number
                    }
                    .frame(width: 70, height: 50)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.gray)
                    .font(.system(size: 20, weight: .bold))
                }
            }
            Spacer()
            
            HStack {
                Button("Confirm") {
                    onConfirm()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Cancel") {
                    onDismiss()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            }
        .padding()
    }
}




struct NewGroupView: View {
    @Binding var isPresented: Bool
    @State private var groupName: String = ""
    @ObservedObject var groupData: GroupData
    @ObservedObject var userStore = UserStore()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Group Name", text: $groupName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    // Generate a new user ID, you may want to replace this with a more robust id generation logic
                    let newUserId = groupData.groups.flatMap { $0.users }.count + 1
                    let newUserDetail = UserDetail(id: newUserId, name: userStore.currentUser?.name ?? "Me", betAmount: 0)
                    let newGroup = Group(id: groupData.groups.count + 1, name: groupName, totalPot: 0, daysLeft: 0, userCount: 1, potHistory: [], users: [newUserDetail])
                    groupData.groups.append(newGroup)
                    self.isPresented = false
                }) {
                    Text("Create Group")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(groupName.isEmpty)
            }
            .navigationTitle("New Group")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow.opacity(0.4)) // Change the background color to your desired color
        }
    }
}

