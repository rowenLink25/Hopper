//
//  BarViewModel.swift
//  Hopper
//
//  Created by Rowen Link on 8/2/23.
//

import Foundation
import FirebaseFirestore
import CoreLocation

func whichEmoji(numUsers : Int) -> String {
    if (numUsers < 0){
        return "😫"
    }
    else if(numUsers >= 0 && numUsers < 10){
        return "😐"
    }
    else if(numUsers >= 10 && numUsers < 20){
        return "🤫"
    }
    else if(numUsers >= 20 && numUsers < 30){
        return "😲"
    }
    else if(numUsers >= 30 && numUsers < 40){
        return "😎"
    }
    else if(numUsers >= 40 && numUsers < 50){
        return "🥳"
    }
    else {
        return "🔥"
    }
}
//Somehow use this to determine how long the wait time will be????
func determineWaitTime(numUsers : Int) -> Int{
    return 0
}
class barViewModel: ObservableObject {
    
    @Published var bars = [Bar]()
    
    private var db = Firestore.firestore()
    
    func fetchDataForUsage(completion: @escaping (Result<[Bar], Error>) -> Void) {
        db.collection("bars").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(.success([]))
                return
            }
            
            let fetchedBars = documents.compactMap { (queryDocumentSnapshot) -> Bar? in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let longitude = data["longitude"] as? String ?? ""
                let latitude = data["latitude"] as? String ?? ""
                let numUsers = data["numUsers"] as? Int ?? 0
                let emoji = whichEmoji(numUsers: numUsers)
                return Bar(numUsers: numUsers, name: name, image: image, longitude: longitude, latitude: latitude, emoji: emoji, coordinates: CLLocationCoordinate2D(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0))
            }
            
            self.bars = fetchedBars
            completion(.success(fetchedBars))
        }
    }
    
    func fetchData() {
        db.collection("bars").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.bars = documents.map { (queryDocumentSnapshot) -> Bar in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let longitude = data["longitude"] as? String ?? ""
                let latitude = data["latitude"] as? String ?? ""
                let numUsers = data["numUsers"] as? Int ?? 0
                let emoji = whichEmoji(numUsers : Int(numUsers))
                return Bar(numUsers: numUsers, name: name, image: image, longitude: longitude, latitude: latitude, emoji: emoji, coordinates: CLLocationCoordinate2D(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0))
            }
        }
    }
    func updateNumUsers(for barName: String, increment: Bool) {
        let db = Firestore.firestore()
        
        db.collection("bars").document(barName).getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error fetching bar data:", error)
                return
            }
            
            if let document = documentSnapshot, document.exists {
                var numUsers = document.data()?["numUsers"] as? Int ?? 0
                numUsers += increment ? 1 : -1
                
                db.collection("bars").document(barName).updateData(["numUsers": numUsers])
            }
        }
    }
}

