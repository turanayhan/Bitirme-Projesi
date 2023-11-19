//
//  UserDefaultsManager.swift
//  Hizmet Burada
//
//  Created by turan on 18.11.2023.
//

import Foundation

class UserDefaultsManager {
    
    
    
    // Kullanıcı adını UserDefaults'a kaydetme
    func setUser(name: String,surname :String,gsm:String,mail : String) {
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(surname, forKey: "surname")
        UserDefaults.standard.set(gsm, forKey: "gsm")
        UserDefaults.standard.set(mail, forKey: "mail")
        
    }
    
    func setId(id: String) {
        UserDefaults.standard.set(id, forKey: "id")
    }
    
    // Kullanıcı adını UserDefaults'dan alma
    func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: "name")
    }
    
    func getUser()->User{
        let name = UserDefaults.standard.string(forKey: "name")
        let surname = UserDefaults.standard.string(forKey: "surname")
        let gsm = UserDefaults.standard.string(forKey: "gsm")
        let mail = UserDefaults.standard.string(forKey: "mail")
        let id = UserDefaults.standard.string(forKey: "id")
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



