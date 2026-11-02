//
//  AllAnnouncementsView.swift
//  Announcer
//
//  Created by Alvin Phyo Htet on 1/11/26.
//

import SwiftUI

struct AllAnnouncementsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        NavigationView {
            NavigationLink(destination: {
                Text("Test")
            }, label: {
                Text("Click me")
            })
        }
        
    }
}

#Preview {
    AllAnnouncementsView()
}
