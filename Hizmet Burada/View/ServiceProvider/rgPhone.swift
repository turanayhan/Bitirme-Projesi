//
//  rgPhone.swift
//  Hizmet Burada
//
//  Created by turan on 30.12.2023.
//

import UIKit
import JGProgressHUD

class rgPhone: UIViewController {
    
    lazy var progresBar:JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.textLabel.text = "Kaydınız Gerçekleşiyor"
        return  progresBar
    }()
    
    
    
    
    lazy var nameSurnameText:UITextView = {
        let infoText = UITextView()
        infoText.text = "Cep telefonun nedir?"
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var nameSurnameText2:UITextView = {
        let infoText = UITextView()
        infoText.text = "Hem hizmetburada hem yeni müşterilerin sana bu numaradan\nulaşacak. "
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
    
    lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Telefon Numarası"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()

    
    lazy var permissionCheckbox: UIButton = {
        let permissionCheckbox = UIButton(type: .system)
        let buttonFrame = CGRect(x: 20, y: 100, width: 30, height: 30)
        permissionCheckbox.frame = buttonFrame
        permissionCheckbox.addTarget(self, action: #selector(checkboxToggled), for: .touchUpInside)
        permissionCheckbox.isSelected = false
        permissionCheckbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        permissionCheckbox.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        return permissionCheckbox
    }()
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "İletişim İzni"
        label.textColor = .black
        label.font = UIFont(name: "Verdana", size: 11)

        // UIImageView oluştur
        let imageView = UIImageView(image: UIImage(named: "chevron.forward"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: label.frame.size.width + 5, y: 0, width: 20, height: 20) // Ayarlamaları ihtiyaca göre yapın

        // UIImageView'i etiketin yanına ekle
        label.addSubview(imageView)

        return label
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
        navigationItem.title = "Devam"
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        navigationItem.title = ""
        stackView.addArrangedSubview(phoneNumberTextField)
        view.addSubview(permissionCheckbox)
        view.addSubview(stackView)
        view.addSubview(registerBtn)
        view.addSubview(nameSurnameText)
        view.addSubview(nameSurnameText2)
        view.addSubview(label)
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
                         size: .init(width: 0, height: 40))
        
        
        
        registerBtn.anchor(top: nil,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           leading: stackView.leadingAnchor,
                           trailing: stackView.trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom:22, right: 0))
        
        permissionCheckbox.anchor(top: stackView.bottomAnchor, bottom: nil, leading: stackView.leadingAnchor, trailing: nil,padding: .init(top: 12, left: 0, bottom: 0, right: 0),size: .init(width: 30, height: 30))
        
        label.anchor(top: permissionCheckbox.topAnchor, bottom: permissionCheckbox.bottomAnchor, leading: permissionCheckbox.trailingAnchor, trailing: stackView.trailingAnchor,padding: .init(top: 0, left: 6, bottom: 0, right: 0))
   
        
    }
    
    
    
    
    
    @objc func textFieldDidChange(textField: UITextField) {
        if phoneNumberTextField.text!.isEmpty  {
            registerBtn.isEnabled = false
            registerBtn.alpha = 0.5
            
        } else {
            registerBtn.isEnabled = true
            registerBtn.alpha = 1
        }
    }
    
    @objc func nextButtonTapped(click : UIButton!){
        RegistrationInformation.rgİnformation.gsm = phoneNumberTextField.text
        navigationController?.pushViewController(Location(), animated: true)
        
        
    }
    

    
    @objc func checkboxToggled() {
           // Checkbox durumunu kontrol et
           if permissionCheckbox.isSelected {
               permissionCheckbox.isSelected = false
               print("İzin verildi.")
           } else {
              permissionCheckbox.isSelected = true
               print("İzin verilmedi.")
           }
       }
    
    @objc func checkboxToggled2() {
           // Checkbox durumunu kontrol et
           if permissionCheckbox.isSelected {
               permissionCheckbox.isSelected = false
               print("İzin verildi.")
           } else {
              permissionCheckbox.isSelected = true
               print("İzin verilmedi.")
           }
       }
}
