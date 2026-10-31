//
//  Test.swift
//  Announcer
//
//  Created by Alvin Phyo Htet on 27/10/26.
//

import SwiftUI
import FirebaseFirestore

struct Test: View {
    
    private let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            
            Button {
                
                Task {
                    await readData(name: "title")
                }
                
            } label: {
                Text("Add data")
            }
            
        }
    }
    
    private func addUser() async {
        do {
            let ref = try await db.collection("users").addDocument(data: [
                "first": "Ada",
                "last": "Lovelace",
                "born": 1815
            ])

            print("Document added with ID: \(ref.documentID)")

        } catch {
            print("Error adding document: \(error)")
        }
    }

    private func readData(name: String) async {
        do {
          let snapshot = try await db.collection("Announcement").getDocuments()
          for document in snapshot.documents {
              print("\(document.documentID) => \(document.data()[name] ?? "No value for key \(name)")")
          }
        } catch {
          print("Error getting documents: \(error)")
        }
    }
    

}



#Preview {
    Test()
}
