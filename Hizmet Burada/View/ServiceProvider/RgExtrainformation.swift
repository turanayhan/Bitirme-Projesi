//
//  RgExtrainformation.swift
//  Hizmet Burada
//
//  Created by turan on 6.01.2024.
//

import UIKit
import FirebaseDatabaseInternal

class RgExtrainformation: UIViewController,UITextViewDelegate {

    var instance:[String:String] = [:]
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Devam", for: .normal)
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
    
    lazy var nameSurnameText:UITextView = {
        let infoText = UITextView()
        infoText.text = "Kendinden Bahset"
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var nameSurnameText2:UITextView = {
        let infoText = UITextView()
        infoText.text = "Eklemem istediğin ekstra bilgileri, iş deneyimlerini yazabilirsin"
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "verdana", size: 12)
        infoText.isEditable = false
        return infoText
    }()
    
    
    
    lazy var textBox:UITextView = {
        let textBox = UITextView(frame: CGRect(x: 50, y: 100, width: 400, height: 300))
        textBox.text = "Ekstra bilgileri girin..."
        textBox.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1) // Arkaplan rengini ve opaklığını ayarlamak için
        textBox.layer.borderWidth = 1.0
        textBox.layer.borderColor = UIColor.lightGray.cgColor
        textBox.layer.cornerRadius = 4.0
        textBox.layer.shadowColor = UIColor.black.cgColor
        textBox.layer.shadowOpacity = 0.1
        textBox.layer.shadowOffset = CGSize(width: 1, height: 1)
        textBox.layer.shadowRadius = 4.0
        textBox.font = UIFont.systemFont(ofSize: 16.0)
        textBox.delegate = self
        return textBox
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        desing()
        
        
    }
    
    func desing(){
        
        view.backgroundColor = .white
        navigationItem.title = ""
        view.addSubview(nextButton)
        view.addSubview(nameSurnameText)
        view.addSubview(nameSurnameText2)
        view.addSubview(textBox)
        nextButton.anchor(top: nil,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 10, left: 10, bottom: 30, right: 10),
                          size: .init(width: 0, height: 40))
        
        nameSurnameText.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 40))
        
        
        
        
        
        nameSurnameText2.anchor(top: nameSurnameText.bottomAnchor,
                                bottom: nil,
                                leading: view.leadingAnchor,
                                trailing: view.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0,
                                               right: 0),size: .init(width: 0, height: 80))
        
        textBox.anchor(top: nameSurnameText2.bottomAnchor,
                       bottom: nil,
                       leading: view.leadingAnchor,
                       trailing: view.trailingAnchor,
                       padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                       size: .init(width: 0, height: 150))
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textBox.text == "Ekstra bilgileri girin..." {
            textBox.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textBox.text.isEmpty {
            textBox.text = "Ekstra bilgileri girin..."
        }
    }
    
    @objc private func nextButtonTapped() {
        RegistrationInformation.rgİnformation.extraİnformation = textBox.text
        navigationController?.pushViewController(rgMailPassword(), animated: true)

    }

    override func viewWillAppear(_ animated: Bool) {
      
    }
    
}
