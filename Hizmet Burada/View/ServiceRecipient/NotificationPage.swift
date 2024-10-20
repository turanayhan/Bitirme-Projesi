//
//  Notification.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//
import JGProgressHUD

import UIKit
import FirebaseFirestoreSwift
import Firebase

class NotificationPage: UIViewController  {
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.customizeBackButton()
      
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .white
      
       
        
    }
    
    
    

}
