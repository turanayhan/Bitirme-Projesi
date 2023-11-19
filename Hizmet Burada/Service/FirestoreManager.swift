//
//  FirestoreManager.swift
//  Hizmet Burada
//
//  Created by turan on 12.11.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import Firebase
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
        
        let ref = Database.database().reference()
        let yeniKullaniciRef = ref.child("User").childByAutoId()

        let yeniKullanici = [
            "name": user.name,
            "surname": user.surname,
            "mail": user.email,
            "gsm": user.gsm,
        ]
        yeniKullaniciRef.setValue(yeniKullanici)
        // Eklenen kullanıcının ID'sini almak
        var kullaniciID = yeniKullaniciRef.key ?? "0"
        App.shared.userDefaultsManager.setId(id: kullaniciID)
        
 
    }
    
    func firebaseUpdate(user : User){
        
        let ref = Database.database().reference()
        let yeniKullaniciRef = ref.child("User").child(App.shared.userDefaultsManager.getUser().id ?? "00")

        let yeniKullanici = [
            "name": user.name,
            "surname": user.surname,
            "mail": user.email,
            "gsm": user.gsm,
            "userId": user.id
        ]
        
        // Kullanıcıyı Firebase Realtime Database'e eklemek
        yeniKullaniciRef.setValue(yeniKullanici)
        // Eklenen kullanıcının ID'sini almak
        var kullaniciID = yeniKullaniciRef.key ?? "0"
        App.shared.userDefaultsManager.setId(id: kullaniciID)
        
 
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
