//
//  Accountİnformation.swift
//  Hizmet Burada
//
//  Created by turan on 18.11.2023.
//

import UIKit

class AccountInformation: UIViewController {
    
    let userModel:User = {
        let model = UserManager.shared.getUser()
        return model
    }()
    
    lazy var container:UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var info:UILabel = {
        let info = UILabel()
        info.backgroundColor = UIColor.clear
        info.font = UIFont.boldSystemFont(ofSize: 24)
        info.text = "Hesap Bilgilerim"
        return info
    }()
    
    lazy var name:UITextField = {
        let name = UITextField()
        let label = UILabel(frame: CGRect(x: 0, y: -30, width: 300, height: 30))
        name.text = userModel.name
        name.borderStyle = .roundedRect
        name.keyboardType = .emailAddress
        label.text = "Ad"
        name.addSubview(label)
        return name
    }()
    
    lazy var surname:UITextField = {
        let surname = UITextField()
        let label = UILabel(frame: CGRect(x: 0, y: -30, width: 300, height: 30))
        surname.text =  userModel.surname
        surname.borderStyle = .roundedRect
        surname.keyboardType = .emailAddress
        label.text = "Soyad"
        surname.addSubview(label)
        return surname
    }()
    
    lazy var mail:UITextField = {
        let mail = UITextField()
        let label = UILabel(frame: CGRect(x: 0, y: -30, width: 300, height: 30))
        mail.text =  userModel.email
        mail.borderStyle = .roundedRect
        mail.keyboardType = .emailAddress
        label.text = "E-mail"
        mail.addSubview(label)
        return mail
    }()
    
    
    lazy var gsm:UITextField = {
        let gsm = UITextField()
        let label = UILabel(frame: CGRect(x: 0, y: -30, width: 300, height: 30))
        gsm.text = userModel.gsm
        gsm.borderStyle = .roundedRect
        gsm.keyboardType = .emailAddress
        label.text = "Telefon numarası"
        gsm.addSubview(label)
        return gsm
    }()
    
    
    lazy var location1:UITextField = {
        let location = UITextField()
        let label = UILabel(frame: CGRect(x: 0, y: -30, width: 300, height: 30))
        location.placeholder = "Malatya"
        location.borderStyle = .roundedRect
        location.keyboardType = .emailAddress
        label.text = "İl / İlçe / Mahalle"
        location.addSubview(label)
        return location
    }()
    
    lazy var location2:UITextField = {
        let location2 = UITextField()
        location2.placeholder = "Yeşilyurt"
        location2.borderStyle = .roundedRect
        location2.keyboardType = .emailAddress
        return location2
    }()
    
    lazy var location3:UITextField = {
        let location3 = UITextField()
        location3.placeholder = "yaka mahallesi"
        location3.borderStyle = .roundedRect
        location3.keyboardType = .emailAddress
        return location3
    }()
    
    lazy var SaveButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Güncelle", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(container)
        container.addSubview(info)
        container.addSubview(name)
        container.addSubview(surname)
        container.addSubview(mail)
        container.addSubview(gsm)
        container.addSubview(location1)
        container.addSubview(location2)
        container.addSubview(location3)
        container.addSubview(SaveButton)
        desing()
    }

    func desing(){
        
        container.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         bottom: view.bottomAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 40, left: 30,
                                        bottom: 0, right: 30))
        info.anchor(top: container.topAnchor,
                    bottom: nil, leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    size: .init(width: 0, height: 40))
        
        name.anchor(top: info.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 50, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        surname.anchor(top: name.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 50, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        mail.anchor(top: surname.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 50, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        gsm.anchor(top: mail.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 50, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        location1.anchor(top: gsm.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 50, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        location2.anchor(top: location1.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 5, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        location3.anchor(top: location2.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 5, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        SaveButton.anchor(top: location3.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 10, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
    }
    

    @objc func buttonClicked() {
            print("Button Clicked!")
        
        
        
        
        FirestoreManager().firebaseUpdate(user: User(name: self.name.text,surname: self.surname.text,gsm: self.gsm.text,email: self.mail.text))
       // navigationController?.pushViewController(Profile(), animated: true)
        _ = navigationController?.popToRootViewController(animated: true)
        }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if navigationController != nil {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationController?.isNavigationBarHidden = false
                self.navigationController?.navigationBar.tintColor = .black
            }
        }
}
