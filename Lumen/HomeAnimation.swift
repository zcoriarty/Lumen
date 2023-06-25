//
//  HomeAnimation.swift
//  Lumen
//
//  Created by Zachary Coriarty on 6/24/23.
//


import SwiftUI

struct HomeAnimation: View {
    
    @State var progress: CGFloat = 0.8
    @State var startAnimation: CGFloat = 0
    @State private var showBreakdown = false

    
    var body: some View {
        
        VStack{
            
            Button(action: {
                showBreakdown = true
            }) {
                GeometryReader { proxy in
                    VStack {
                        // MARK: Wave Form
                        GeometryReader{proxy in
                            
                            let size = proxy.size
                            
                            ZStack{
                                
                                // MARK: Water Drop
                                Image(systemName: "drop.fill")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.white)
                                
                                // Streching in X Axis
                                    .scaleEffect(x: 1.1,y: 1)
                                    .offset(y: -1)
                                
                                // Wave Form Shape
                                WaterWave(progress: progress, waveHeight: 0.1, offset: startAnimation)
                                    .fill(Color(hex: "#FFE800"))
                                    .rotationEffect(.degrees(180)) // Rotate the wave shape upside down
                                // Water Drops
                                    .overlay(content: {
                                        ZStack{
                                            
                                            Circle()
                                                .fill(.white.opacity(0.1))
                                                .frame(width: 15, height: 15)
                                                .offset(x: -20)
                                            
                                            Circle()
                                                .fill(.white.opacity(0.1))
                                                .frame(width: 15, height: 15)
                                                .offset(x: 40,y: 30)
                                            
                                            Circle()
                                                .fill(.white.opacity(0.1))
                                                .frame(width: 25, height: 25)
                                                .offset(x: -30,y: 80)
                                            
                                            Circle()
                                                .fill(.white.opacity(0.1))
                                                .frame(width: 25, height: 25)
                                                .offset(x: 50,y: 70)
                                            
                                            Circle()
                                                .fill(.white.opacity(0.1))
                                                .frame(width: 10, height: 10)
                                                .offset(x: 40,y: 100)
                                            
                                            Circle()
                                                .fill(.white.opacity(0.1))
                                                .frame(width: 10, height: 10)
                                                .offset(x: -40,y: 50)
                                        }
                                    })
                                // Masking into Drop Shape
                                    .mask {
                                        
                                        Image(systemName: "drop.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(20)
                                    }
                                // Add Button
        //                        .overlay(alignment: .bottom){
        //
        //                            Button {
        //                                progress += 0.01
        //                            } label: {
        //                                Image(systemName: "plus")
        //                                    .font(.system(size: 40, weight: .black))
        //                                    .foregroundColor(Color("Blue"))
        //                                    .shadow(radius: 2)
        //                                    .padding(25)
        //                                    .background(.white,in: Circle())
        //                            }
        //                            .offset(y: 40)
        //                        }
                            }
                            .frame(width: size.width, height: size.height, alignment: .center)
                            .onAppear {
                                
                                // Lopping Animation
                                withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)){
                                    // If you set value less than the rect width it will not finish completely
                                    startAnimation = size.width
                                }
                            }
                        }
                        .frame(height: 350)
                    }
                    .rotationEffect(.degrees(180)) // Rotate the view upside down
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
            }
            .sheet(isPresented: $showBreakdown) {
                ScrollView {
                    Text("Why Use Lumen")
                        .font(.system(size: 35, weight: .heavy))
                        .padding(.top)
                   let education = """
                    1. Air Conditioning and Heating: These systems can account for nearly half of a home's energy usage. Regular maintenance and sealing your home against drafts can significantly reduce your energy usage.
                    
                     2. Water Heaters: Water heaters are typically the second highest source of energy usage in the home. Lowering the temperature to 120 degrees Fahrenheit can help save energy.
                    
                     3. Washing Machines and Dryers: Front-loading washing machines are more energy-efficient than top-loading ones. Always run full loads and clean the lint filter in the dryer after every use.
                    
                     4. Refrigerators and Freezers: These appliances account for about a sixth of all electricity use in a typical American home. Keep the refrigerator between 35 and 38 degrees Fahrenheit and the freezer at 0 degrees.
                    
                     5. Lighting: LED light bulbs use at least 75% less energy, and last 25 times longer, than incandescent lighting. Turning off lights when not in use can also help reduce energy usage.
                    
                     6. Electronics: Even when turned off, electronics often use a small amount of electricity. Using a power strip for your electronics and turning it off when not in use can help reduce energy consumption.
                    
                     7. Dishwashers: Dishwashers use less water than washing dishes by hand. Air-drying dishes instead of using the heat dry setting can also save energy.
                    
                     8. Ovens and Stovetops: Using a microwave or toaster oven to reheat food or cook small meals can save as much as 80% of the energy used to cook in a conventional oven.
                    
                     9. Computers and Home Office Equipment: Laptops are more energy-efficient than desktop computers. Using power management settings can significantly reduce energy use.
                    """
                    Text(education)
                        .padding()
                }
            }

            
            
//            Slider(value: $progress)
//                .padding(.top,50)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//        .background(Color("BG"))
    }
}


struct HomeAnimation_Previews: PreviewProvider {
    static var previews: some View {
        HomeAnimation()
    }
}

struct WaterWave: Shape{
    
    var progress: CGFloat
    // Wave Height
    var waveHeight: CGFloat
    // Intial Animation Start
    var offset: CGFloat
    
    // Enabling Animation
    var animatableData: CGFloat{
        get{offset}
        set{offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: .zero)
            
            // MARK: Drawing Waves using Sine
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2){
                
                let x: CGFloat = value
                let sine: CGFloat = sin(Angle(degrees: value + offset).radians)
                let y: CGFloat = progressHeight + (height * sine)
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            // Bottom Portion
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

