//
//  FirestoreManager.swift
//  Hizmet Burada
//
//  Created by turan on 12.11.2023.
//

import Foundation

import FirebaseFirestore
import FirebaseStorage

class FirestoreManager {
    let db = Firestore.firestore()
    
    func fetchUsers(completion: @escaping ([WorkList]?, Error?) -> Void) {
        db.collection("HizmetBurada").getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                completion(nil, error)
                return
            }
            
            let list = documents.compactMap { document -> WorkList? in
                do {
                    let user = try document.data(as: WorkList.self)
                    
                    return user
                } catch {
                    completion(nil, error)
                    return nil
                }
            }
            
            
            
            
            completion(list, nil)
        }
    }
    
    
    
    
    
    
    
    func firebasePush(user : User){
        
        let db = Firestore.firestore()
        do {
            let jsonData = try JSONEncoder().encode(user)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            if let jsonDictionary = jsonObject as? [String: Any] {
                let documentID = "user" // Kendi belge kimliğinizi belirtin veya otomatik bir belge kimliği oluşturun
                
                // Firestore'a sözlük olarak veri eklemek için
                db.collection("HizmetBurada").document(documentID).setData(jsonDictionary) { error in
                    if let error = error {
                        print("Veri eklenirken hata oluştu: \(error)")
                    } else {
                        print("Veri başarıyla eklendi")
                    }
                }
            }
        } catch {
            print("Veri kodlanırken hata oluştu: \(error)")
        }
 
    }
    
    
    
    
    func downloadImage(from path: String, completion: @escaping (UIImage?) -> Void) {
        let storageRef = Storage.storage().reference(withPath: path)

        storageRef.getData(maxSize: 1 * 512 * 512) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
            } else {
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
    }
   
}






