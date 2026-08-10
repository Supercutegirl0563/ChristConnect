//
//  Home.swift
//  Announcer
//
//  Created by Alvin Phyo Htet on 10/8/26.
//

import SwiftUI

struct Home: View {
    
    @State private var username = "User"
    
    var body: some View {
        ZStack {
            Color(white:0.95)  // Background Color
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                Text("Good morning, \(username)")
                    .bold()
                    .font(.title2)
                Text("Welcome back to ChristConnect")
                
                Rectangle() // Announcement Tab
                    .fill(.white)
                    .frame(width: 300, height: 100)
                    .cornerRadius(20)
                    .overlay(
                        
                        ZStack {
                            
                            VStack(alignment: .leading) {
                                Text("Announcements")
                                    .bold()
                                    .offset(y: -30)
                            }
                            
                        }
                        
                    )
                
                
                Text("Quick Access")
                    .font(.title2)
                    .bold()
                
            }
            
        }
    }
}

#Preview {
    Home()
}
