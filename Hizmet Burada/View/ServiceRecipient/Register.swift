//
//  Register.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//

import UIKit
import FirebaseAuth
import Firebase
import JGProgressHUD

class Register: UIViewController {
    
    lazy var progresBar:JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.textLabel.text = "Kaydınız Gerçekleşiyor"
        return  progresBar
    }()
    
    lazy var logo:UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 9
        return stackView
    }()
    
    lazy var name:UITextField = {
        let nameSurname = UITextField()
        nameSurname.placeholder = "Ad"
        nameSurname.borderStyle = .roundedRect
        nameSurname.keyboardType = .emailAddress
        nameSurname.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return nameSurname
    }()
    
    lazy var surname:UITextField = {
        let surname = UITextField()
        surname.placeholder = "Soyad"
        surname.borderStyle = .roundedRect
        surname.keyboardType = .emailAddress
        surname.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return surname
    }()

    lazy var mail:UITextField = {
        let mail = UITextField()
        mail.placeholder = "E-mail"
        mail.borderStyle = .roundedRect
        mail.keyboardType = .emailAddress
        mail.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return mail
    }()
    
    lazy var password:UITextField = {
        let password = UITextField()
        password.placeholder = "şifreni gir"
        password.borderStyle = .roundedRect
        password.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return password
    }()
    
    lazy var registerBtn:UIButton = {
        let registerBtn = UIButton()
        registerBtn.setTitle("Kayıt Ol", for: .normal)
        registerBtn.backgroundColor = .systemYellow
        registerBtn.setTitleShadowColor(.white, for: .focused)
        registerBtn.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        registerBtn.setTitleColor(.white, for: .normal)
        registerBtn.setTitleColor(.red, for: .highlighted)
        registerBtn.layer.cornerRadius = 4
        registerBtn.isEnabled = false
        registerBtn.alpha = 0.5
        return registerBtn
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Kayıt Ol"
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(surname)
        stackView.addArrangedSubview(mail)
        stackView.addArrangedSubview(password)
        view.addSubview(stackView)
        view.addSubview(registerBtn)
        view.addSubview(logo)
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
                         size: .init(width: 0, height: view.frame.height/5))
        
        stackView.centerAnchor()
        
        registerBtn.anchor(top: stackView.bottomAnchor,
                        bottom: nil,
                        leading: stackView.leadingAnchor,
                        trailing: stackView.trailingAnchor,
                        padding: .init(top: 12, left: 0, bottom: 0, right: 0))
  
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if name.text!.isEmpty || mail.text!.isEmpty || password.text!.isEmpty{
            registerBtn.isEnabled = false
            registerBtn.alpha = 0.5
            
        } else {
            registerBtn.isEnabled = true
            registerBtn.alpha = 1
        }
    }
    
    @objc func registerClick(click : UIButton!){
        progresBar.show(in: self.view)
  
        Auth.auth().createUser(withEmail: self.mail.text!, password: self.password.text!) { response, error in
            if let response = response {
                print("hata")
                self.progresBar.dismiss(afterDelay: 3.0)
               
                
                return
            }
            
            FirestoreManager().firebasePush(user: User(name: self.name.text,
                                                       surname: self.surname.text,
                                                       gsm: "+90",
                                                       email: self.mail.text)
            )
            
            
            
          
            
           
           //popup yapılacak
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        print(Date())
                self.progresBar.dismiss(afterDelay: 2.0)
                print("kullanıcı başarıyla kaydedildi")
                self.navigationItem.title = ""
                self.navigationController?.isNavigationBarHidden = true
                self.navigationController?.pushViewController(Login(), animated: true)
                    }
        }
        
    }

}
