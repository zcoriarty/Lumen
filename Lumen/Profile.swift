//
//  Home.swift
//  BarGraphGestures (iOS)
//
//  Created by Balaji on 02/11/21.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 15){
                Text("Your Metrics")
                    .font(.system(size: 40, weight: .heavy))
                
                // Download Stats....
                DownloadStats()
                
                // Followers Stats...
                FollowersStats()
                
                // Payment View..
                HStack{
                    
                    Text("$95.00")
                        .font(.title2.bold())
                        .foregroundColor(.gray)
                    
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Cash Out")
                            .font(.callout)
                            .foregroundColor(Color.black)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(
                            
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(hex: "#FFE800"))
                            )
                    }
                }
                .padding()
            }
            .padding(15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color("BG").ignoresSafeArea())
//        .preferredColorScheme(.dark)
        
    }
    
    @ViewBuilder
    func FollowersStats()->some View{
        
        VStack{
            
            HStack{
                
                
                Image(systemName: "checkmark")
                    .font(.caption.bold())
                    .foregroundColor(Color("BG"))
                    .padding(6)
                    .background(Color(hex: "#FFE800"))
                    .cornerRadius(8)
                
                Text("Total Usage")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .padding(.trailing,10)
                
                Image(systemName: "play.fill")
                    .font(.caption.bold())
                    .foregroundColor(Color("BG"))
                    .padding(6)
                    .background(Color(hex: "#FFE800"))
                    .cornerRadius(8)
                
                Text("Saved")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .padding(.trailing,10)
            }
            
            VStack(spacing: 15){
                
                Text("$848.53")
                    .font(.largeTitle.bold())
                    .scaleEffect(1.3)
                
                Text("Rent Savings This Month")
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            .padding(.top,25)
            
            // Following Followers Stats...
            
            HStack(spacing: 10){
                
                StatView(title: "Followers", count: "187.5kWh", image: "checkmark", color: "Green")
                
                SavedView(title: "Following", count: "27.57kWh", image: "play.fill", color: "Purple")
            }
            .padding(.top)
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(
        
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.1))
        )
    }
    
    @ViewBuilder
    func StatView(title: String,count: String,image: String,color: String)->some View{
        
        VStack(alignment: .leading, spacing: 25) {
            
            HStack{
                Image(systemName: image)
                    .font(.caption.bold())
                    .foregroundColor(Color(hex: "#FFE800"))
                    .padding(6)
                    .background(Color("BG"))
                    .cornerRadius(8)
                
                Text("Total Usage")
            }
            
            Text(count)
                .font(.system(size: 20, weight: .bold))
        }
        .foregroundColor(Color("BG"))
        .padding(.vertical,22)
        .padding(.horizontal,18)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(Color(hex: "#FFE800"))
        .cornerRadius(15)
    }
    
    @ViewBuilder
    func SavedView(title: String,count: String,image: String,color: String)->some View{
        
        VStack(alignment: .leading, spacing: 25) {
            
            HStack{
                Image(systemName: image)
                    .font(.caption.bold())
                    .foregroundColor(Color(hex: "#FFE800"))
                    .padding(6)
                    .background(Color("BG"))
                    .cornerRadius(8)
                
                Text("Energy Saved")
            }
            
            Text(count)
                .font(.system(size: 20, weight: .bold))
        }
        .foregroundColor(Color("BG"))
        .padding(.vertical,22)
        .padding(.horizontal,18)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(Color(hex: "#FFE800"))
        .cornerRadius(15)
    }

    
    @ViewBuilder
    func DownloadStats()->some View{
        
        VStack(spacing: 15){
            
            HStack{
                
                VStack(alignment: .leading, spacing: 13) {
                    
                    Text("Energy Usage")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Menu {
                        
                    } label: {
                        
                        Label {
                            Image(systemName: "chevron.down")
                        } icon: {
                            Text("Last 7 Days")
                        }
                        .font(.callout)
                        .foregroundColor(.gray)

                    }

                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.up.forward")
                        .font(.title2.bold())
                }
                .foregroundColor(.white)
                .offset(y: -10)

            }
            
            // Bar Graph With Gestures...
            BarGraph(downloads: weekDownloads)
                .padding(.top,25)
        }
        .padding(15)
        .background(
        
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.1))
        )
        .padding(.vertical,20)
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
