//
//  Profile.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//


import UIKit
import Firebase
import JGProgressHUD
import FirebaseStorage
import JGProgressHUD




class ProfileService: UIViewController   {
    
    
    lazy var progresBar: JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.textLabel.text = "Yükleniyor..."
        return progresBar
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(hex: "#F1FAFE")
  
        
        
    
    }
    
    
    
    
    
    }
