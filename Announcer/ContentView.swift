//
//  ContentView.swift
//  Announcer
//
//  Created by Alvin Phyo Htet on 9/8/26.
//

import SwiftUI
struct ContentView: View {
    
    
    var body: some View {
        
        TabView {
            
            Tab("Announcement", systemImage: "list.bullet.rectangle.fill") {
                Home()
            }
            
            Tab("Settings", systemImage: "gear") {
                Settings()
            }
            
        }
        
        
    }
}

#Preview {
    ContentView()
}
