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
        UserManager.shared.setId(id: kullaniciID)
        UserManager.shared.setUser(user: user)
        
        
 
    }
    
    func firebasePushService(){
        
        let ref = Database.database().reference()
        let yeniKullaniciRef = ref.child("UserService").childByAutoId()
        var id = yeniKullaniciRef.key ?? "0"

        let registrationInfo = RegistrationInformation.rgİnformation
        registrationInfo.userİd = id
        let registrationDictionary: [String: Any?] = [
            "name": registrationInfo.name,
            "surname": registrationInfo.surname,
            "gsm": registrationInfo.gsm,
            "locationCity": registrationInfo.locationCity,
            "district": registrationInfo.district,
            "neighbourhood": registrationInfo.neighbourhood,
            "answerSelection": registrationInfo.answerSelection,
            "extraInformation": registrationInfo.extraİnformation,
            "mail": registrationInfo.mail,
            "userId": registrationInfo.userİd
        ]

        for (key, value) in registrationDictionary {
            print("\(key): \(value ?? "N/A")")
        }

        yeniKullaniciRef.setValue(registrationDictionary)
  
        UserManager.shared.setId(id: id)
        UserManager.shared.setUser(user : User(name:registrationInfo.name,
                                              surname: registrationInfo.surname,
                                              gsm: registrationInfo.gsm,
                                              email: registrationInfo.mail,
                                              id: registrationInfo.userİd))
   
 
    }
    
    
    func firebaseUpdate(user : User){
        
        let ref = Database.database().reference()
        let yeniKullaniciRef = ref.child("User").child(UserManager.shared.getUser().id ?? "00")
        print(UserManager.shared.getUser().id ?? "00")

        let yeniKullanici = [
            "name": user.name,
            "surname": user.surname,
            "mail": user.email,
            "gsm": user.gsm,
            "userId": user.id
        ]
        
        // Kullanıcıyı Firebase Realtime Database'e eklemek
        yeniKullaniciRef.setValue(yeniKullanici)
        UserManager.shared.setUser(user:user)
       
    }
    
    
    
    
    func fetchJobModel(completion: @escaping ([String: Any]) -> Void) {
        let databaseRef = Database.database().reference()
        var gelenddeger: [String: Any] = [:]

        databaseRef.child("İs Bilgileri").observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? [String: Any] {
                gelenddeger = value
                completion(gelenddeger)
            } else {
                completion([:])
            }
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
