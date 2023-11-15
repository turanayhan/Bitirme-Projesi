//
//  Profile.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//


import UIKit

class Profile: UIViewController {
    
    lazy var stackView:UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        return stackView
        
    }()
    
    lazy var logo:UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo2")
        logo.contentMode = .scaleAspectFill
        return logo
        
    }()
    
    lazy var infoText:UITextView = {
        
        let infoText = UITextView()
        infoText.text = "Giriş yapınca profilini buradan\ndüzenleyebilirsin."
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Thonburi", size: 14)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var registerBtn:UIButton = {
        
        let registerBtn = UIButton()
        registerBtn.setTitle("Hemen Üye Ol", for: .normal)
        registerBtn.backgroundColor = .red
        registerBtn.setTitleShadowColor(.white, for: .focused)
        registerBtn.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        registerBtn.setTitleColor(.white, for: .normal)
        registerBtn.setTitleColor(.red, for: .highlighted)
        registerBtn.isEnabled = true
        registerBtn.layer.cornerRadius = 4
        return registerBtn
        
    }()
    
    lazy var loginBtn:UIButton = {
        
        let loginBtn = UIButton()
        loginBtn.setTitle("Giriş Yap", for: .normal)
        loginBtn.backgroundColor = .white
        loginBtn.setTitleColor(.red, for: .normal)
        loginBtn.setTitleColor(.white, for: .highlighted)
        loginBtn.layer.cornerRadius = 4
        loginBtn.layer.borderColor = UIColor.red.cgColor
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.layer.borderWidth = 0.8
        return loginBtn
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""

        desing()
       
    }
    
    
    
    func desing (){
        stackView.addArrangedSubview(registerBtn)
        stackView.addArrangedSubview(loginBtn)
        view.addSubview(stackView)
        view.backgroundColor = .white
        view.addSubview(logo)
        view.addSubview(infoText)
    
        
        //constrait atama fonksiyonu
        stackView.anchor(top: nil,
                         bottom: nil,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 32, bottom: 0, right: 32),
                         size: .init(width: 0, height: 90))
        stackView.centerAnchor()
        
        
        logo.anchor(top: view.topAnchor,
                    bottom: infoText.topAnchor,
                    leading: view.leadingAnchor,
                    trailing: view.trailingAnchor,
                    padding: .init(top: 100, left: 30, bottom:6, right: 30),
                    size: .init(width: 0, height: 0))
        
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        infoText.anchor(top: nil,
                        bottom: stackView.topAnchor,
                        leading: logo.leadingAnchor,
                        trailing: logo.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 24, right: 0),
                        size: .init(width: 0, height: 60))
        
        
    }

    
    
    
    
    
    @objc func registerClick(click :UIButton!){
        print("kayıt olundu")
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(Register(), animated: true)
    }
    
    @objc func loginClick(click :UIButton!){
        print("giriş yapıldı")
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(Login(), animated: true)
    }
   
    @objc func passwordtBtnClick(click : UIButton!){
        
        
    }
}
