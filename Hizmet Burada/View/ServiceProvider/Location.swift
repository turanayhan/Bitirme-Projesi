//
//  Location.swift
//  Hizmet Burada
//
//  Created by turan on 6.01.2024.
//

import UIKit
import JGProgressHUD

class Location: UIViewController {
    lazy var progresBar:JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.textLabel.text = "Kaydınız Gerçekleşiyor"
        return  progresBar
    }()
    
    
    
    
    lazy var nameSurnameText:UITextView = {
        let infoText = UITextView()
        infoText.text = "Nerede Hizmet Veriyorsun?"
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var nameSurnameText2:UITextView = {
        let infoText = UITextView()
        infoText.text = "Sana yakın bölgelerden iş fırsatlarını göndereceğiz "
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "verdana", size: 11)
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
    
    lazy var location1: UITextField = {
        let location1 = UITextField()
        location1.placeholder = "İl"
        location1.borderStyle = .roundedRect
        location1.keyboardType = .phonePad
        location1.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return location1
    }()
    lazy var location2: UITextField = {
        let location2 = UITextField()
        location2.placeholder = "İlçe"
        location2.borderStyle = .roundedRect
        location2.keyboardType = .phonePad
        location2.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return location2
    }()
    lazy var location3: UITextField = {
        let location3 = UITextField()
        location3.placeholder = "Mahalle"
        location3.borderStyle = .roundedRect
        location3.keyboardType = .phonePad
        location3.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return location3
    }()

    lazy var registerBtn:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Devam", for: .normal)
        button.alpha = 0.5
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 2
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        stackView.addArrangedSubview(location1)
        stackView.addArrangedSubview(location2)
        stackView.addArrangedSubview(location3)
        view.addSubview(stackView)
        view.addSubview(registerBtn)
        view.addSubview(nameSurnameText)
        view.addSubview(nameSurnameText2)
        desing()
    }
    
    func desing(){
        
        nameSurnameText.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 40))
        
        nameSurnameText2.anchor(top: nameSurnameText.bottomAnchor,
                                bottom: nil,
                                leading: view.leadingAnchor,
                                trailing: view.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0,
                                               right: 0),size: .init(width: 0, height: 80))
        
        stackView.anchor(top: nameSurnameText2.bottomAnchor,
                         bottom: nil,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 36, bottom: 0, right: 36),
                         size: .init(width: 0, height: 120))
        
        
        
        registerBtn.anchor(top: nil,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           leading: stackView.leadingAnchor,
                           trailing: stackView.trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom:22, right: 0))

   
        
    }
    
    
    
    
    
    @objc func textFieldDidChange(textField: UITextField) {
        if location1.text!.isEmpty  {
            registerBtn.isEnabled = false
            registerBtn.alpha = 0.5
            
        } else {
            registerBtn.isEnabled = true
            registerBtn.alpha = 1
        }
    }
    
    @objc func nextButtonTapped(click : UIButton!){
        RegistrationInformation.rgİnformation.locationCity = location1.text
        RegistrationInformation.rgİnformation.district = location2.text
        RegistrationInformation.rgİnformation.neighbourhood = location3.text
        
        navigationController?.pushViewController(AnswerSelection(), animated: true)
        
        
    }
    

 
}
