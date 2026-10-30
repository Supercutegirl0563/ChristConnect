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
                    await readData()
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

    private func readData() async {
        do {
          let snapshot = try await db.collection("users").getDocuments()
          for document in snapshot.documents {
              print("\(document.documentID) => \(type( of:document.data()["last"] ?? "Not found"))")
          }
        } catch {
          print("Error getting documents: \(error)")
        }
    }
    

}



#Preview {
    Test()
}
