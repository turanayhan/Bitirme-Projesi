//
//  rgMailPassword.swift
//  Hizmet Burada
//
//  Created by turan on 6.01.2024.
//

import UIKit
import FirebaseAuth

class rgMailPassword: UIViewController {
    
    lazy var nameSurnameText:UITextView = {
        let infoText = UITextView()
        infoText.text = "Hesap Oluştur"
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var nameSurnameText2:UITextView = {
        let infoText = UITextView()
        infoText.text = "Mail ve şifreni belirleyerek kaydını kolayca tamamla"
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "verdana", size: 12)
        infoText.isEditable = false
        return infoText
    }()
    
    
    lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 9
        return stackView
    }()
    
    lazy var mail:UITextField = {
        let mail = UITextField()
        mail.placeholder = "E-mail"
        mail.borderStyle = .roundedRect
        mail.keyboardType = .emailAddress
        return mail
    }()
    
    lazy var password:UITextField = {
        let password = UITextField()
        password.placeholder = "şifreni gir"
        password.borderStyle = .roundedRect
        return password
    }()
    
    lazy var loginBtn:UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("Ücretsiz Üye Ol", for: .normal)
        loginBtn.backgroundColor = .systemYellow
        loginBtn.setTitleShadowColor(.white, for: .focused)
        loginBtn.addTarget(self, action: #selector(rgClick), for: .touchUpInside)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.setTitleColor(.red, for: .highlighted)
        loginBtn.isEnabled = true
        loginBtn.layer.cornerRadius = 4
        return loginBtn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        navigationItem.title = ""
        stackView.addArrangedSubview(mail)
        stackView.addArrangedSubview(password)
        view.addSubview(stackView)
        view.addSubview(nameSurnameText)
        view.addSubview(nameSurnameText2)
        view.addSubview(loginBtn)
        
        desing()
        
    }
    
    func desing(){
        
        
        
        stackView.anchor(top: nil,
                         bottom: nil,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 36, bottom: 0, right: 36),
                         size: .init(width: 0, height: 90))
        
        stackView.centerAnchor()
        
        loginBtn.anchor(top: stackView.bottomAnchor,
                        bottom: nil,
                        leading: stackView.leadingAnchor,
                        trailing: stackView.trailingAnchor,
                        padding: .init(top: 12, left: 0, bottom: 0, right: 0))
        
        
        
        password.centerXAnchor.constraint(equalTo: loginBtn.centerXAnchor).isActive = true
        
        nameSurnameText.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 40))
        
        
        
        
        
        nameSurnameText2.anchor(top: nameSurnameText.bottomAnchor,
                                bottom: nil,
                                leading: view.leadingAnchor,
                                trailing: view.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0,
                                               right: 0),size: .init(width: 0, height: 80))
        
        
        
    }
    
    @objc func rgClick(click : UIButton!){
        
        RegistrationInformation.rgİnformation.mail = mail.text
        var manager = FirestoreManager()
      
        
        
        
        Auth.auth().createUser(withEmail: self.mail.text!, password: self.password.text!) { response, error in
            if let response = response {
                print("hata")
               
                manager.firebasePushService()
                self.navigationItem.title = ""
                self.navigationController?.isNavigationBarHidden = true
                self.navigationController?.pushViewController(ExtraLogin(), animated: true)
                
                return
            }
            
            
        
            
        }
        
        
        
    }
    
}
