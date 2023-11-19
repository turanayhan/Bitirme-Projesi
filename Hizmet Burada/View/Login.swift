//
//  Login.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//

import UIKit
import Firebase

class Login: UIViewController {
    
    lazy var logo:UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleToFill
        return logo
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
        loginBtn.setTitle("Giriş Yap", for: .normal)
        loginBtn.backgroundColor = .systemYellow
        loginBtn.setTitleShadowColor(.white, for: .focused)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.setTitleColor(.red, for: .highlighted)
        loginBtn.isEnabled = true
        loginBtn.layer.cornerRadius = 4
        return loginBtn
    }()
    
    lazy var passwordBtn:UIButton = {
        let registerBtn = UIButton()
        registerBtn.setTitle("Şifremi unuttum", for: .normal)
        registerBtn.backgroundColor = .white
        registerBtn.setTitleShadowColor(.white, for: .focused)
        registerBtn.addTarget(self, action: #selector(passwordtBtnClick), for: .touchUpInside)
        registerBtn.setTitleColor(.systemYellow, for: .normal)
        registerBtn.setTitleColor(.white, for: .highlighted)
        registerBtn.isEnabled = true
        return registerBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Giriş Yap"
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        stackView.addArrangedSubview(mail)
        stackView.addArrangedSubview(password)
        view.addSubview(stackView)
        view.addSubview(loginBtn)
        view.addSubview(logo)
        view.addSubview(passwordBtn)
        desing()
        
    }
    
    func desing(){
        
        logo.anchor(top: nil,
                    bottom: stackView.topAnchor,
                    leading: nil,
                    trailing: nil,
                    padding: .init(top: 12, left: 12, bottom: 16, right: 12),size: .init(width: 300, height: 300)
                    )
        logo.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        
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
        
        passwordBtn.anchor(top: loginBtn.bottomAnchor,
                           bottom: nil, leading: loginBtn.leadingAnchor,
                           trailing: loginBtn.trailingAnchor,
                           padding: .init(top: 12, left: 12, bottom: 0, right: 12)
                           )
        
        password.centerXAnchor.constraint(equalTo: loginBtn.centerXAnchor).isActive = true
        
    }

    @objc func loginClick(click : UIButton!){
        
        print("firebase işlemleri")
        
        Auth.auth().signIn(withEmail: self.mail.text ?? "",
                           password: self.password.text ?? "") { [weak self] authResult, error in
                   guard let self = self else { return }

                   if let error = error {
                       print("Giriş hatası: \(error.localizedDescription)")
                   } else {
                       print("Giriş başarılı")
                       self.navigationItem.title = ""
                       self.navigationController?.pushViewController(Profile(), animated: true)
                       self.navigationController?.isNavigationBarHidden = true
                       
                   }
               }
    }

    @objc func passwordtBtnClick(click : UIButton!){
        print("şifremi unuttum")
    }

}
