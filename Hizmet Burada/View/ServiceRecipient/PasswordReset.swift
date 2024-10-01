//
//  PasswordReset.swift
//  Hizmet Burada
//
//  Created by turan on 1.10.2024.
//

import JGProgressHUD

import UIKit
import FirebaseFirestoreSwift
import Firebase

class PasswordReset: UIViewController  {
   

    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .white
      
       sendPasswordReset(email: "duranayhan57@gmail.com")
        
    }
    
    func sendPasswordReset(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                // Hata durumunu işleme
                print("Şifre sıfırlama e-posta gönderilemedi: \(error.localizedDescription)")
            } else {
                // Şifre sıfırlama e-postası başarıyla gönderildi
                print("Şifre sıfırlama e-postası gönderildi!")
            }
        }
    }
    

}
