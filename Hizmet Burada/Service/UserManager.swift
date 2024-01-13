//
//  UserDefaultsManager.swift
//  Hizmet Burada
//
//  Created by turan on 18.11.2023.
//

import Foundation

class UserManager {
    
   static let shared = UserManager()
    
    // Kullanıcı adını UserDefaults'a kaydetme
    func setUser(user : User) {
        UserDefaults.standard.set(user.name, forKey: "name")
        UserDefaults.standard.set(user.surname, forKey: "surname")
        UserDefaults.standard.set(user.gsm, forKey: "gsm")
        UserDefaults.standard.set(user.email, forKey: "mail")
        
    }

    
    func setId(id: String){
        UserDefaults.standard.set(id, forKey: "id")
    }
    
    // Kullanıcı adını UserDefaults'dan alma
    func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: "name")
    }
    
    func getUser()->User{
        var name = UserDefaults.standard.string(forKey: "name")
        var surname = UserDefaults.standard.string(forKey: "surname")
        var gsm = UserDefaults.standard.string(forKey: "gsm")
        var mail = UserDefaults.standard.string(forKey: "mail")
        var id = UserDefaults.standard.string(forKey: "id")
        return User(name: name,surname: surname,gsm: gsm,email: mail,id: id)
    }
    // Kullanıcı adını UserDefaults'tan silme
    func removeUserName() {
        UserDefaults.standard.removeObject(forKey: "name")
    }
    
    func isUserLoggedIn() -> Bool {
           return getUserName() != nil
       }
    
}



