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

    lazy var stackView:UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .blue
        stackView.distribution = .fillEqually
        stackView.spacing = 9
        return stackView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        
        
              }

        
      
    }


