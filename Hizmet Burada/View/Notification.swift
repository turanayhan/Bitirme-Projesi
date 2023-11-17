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

class Notification: UIViewController {
    
    lazy var containerProfile:UIView = {
        
        let container = UIView()
        container.backgroundColor = .white
        return container
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(containerProfile)
        
        
        containerProfile.anchor(top: view.topAnchor,
                         bottom: view.bottomAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor)
        
        
    }
    
    
    
    
    
}
