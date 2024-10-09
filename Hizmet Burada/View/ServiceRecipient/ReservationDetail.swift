//
//  ReservationDetail.swift
//  Hizmet Burada
//
//  Created by turan on 30.11.2023.
//

import UIKit
import Firebase

class ReservationDetail: UIViewController ,UITextViewDelegate {
    
    var instance:[String:String] = [:]
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tamamla", for: .normal)
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
    
    lazy var infoText:UITextView = {
        let infoText = UITextView()
        infoText.textColor = .systemYellow
        infoText.font = UIFont(name: "Avenir", size: 18)
        infoText.isEditable = false
        infoText.textAlignment = .center
        infoText.delegate = self
        infoText.text = "Bilmemiz gereken başka hangi detaylar var?"
        return infoText
    }()
    
    
    lazy var textBox: UITextView = {
        let textBox = UITextView()
        textBox.translatesAutoresizingMaskIntoConstraints = false // Auto Layout kullanabilmek için
        textBox.text = "Ekstra bilgileri girin..."
        textBox.textColor = UIColor.lightGray // Placeholder rengi
        textBox.backgroundColor = UIColor(red: 1.0, green: 0.97, blue: 0.85, alpha: 1) // Arka plan rengi
        textBox.layer.borderWidth = 1.0
        textBox.layer.borderColor = UIColor.lightGray.cgColor
        textBox.layer.cornerRadius = 8.0 // Kenar yuvarlama
        textBox.layer.shadowColor = UIColor.black.cgColor
        textBox.layer.shadowOpacity = 0.2 // Gölgede daha belirgin bir etki
        textBox.layer.shadowOffset = CGSize(width: 0, height: 2) // Dikey gölge
        textBox.layer.shadowRadius = 4.0
        textBox.font = UIFont(name: "Avenir", size: 16)
        textBox.textAlignment = .left // Yazı hizalaması
        textBox.returnKeyType = .done // Klavyede "Tamam" tuşu
        textBox.delegate = self
        textBox.layer.masksToBounds = false // Kenar yuvarlamasının gölgesini göstermek için
        return textBox
    }()

    var key : String = ""
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        key = infoText.text.replacingOccurrences(of: "?", with: "")
        Jobİnformation.shared.addInfo(key: key, value: textBox.text)
        desing()
        
        
    }
    
    func desing(){
        
        view.backgroundColor = .white
        view.addSubview(nextButton)
        view.addSubview(infoText)
        view.addSubview(textBox)
        nextButton.anchor(top: nil,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 10, left: 10, bottom: 30, right: 10),
                          size: .init(width: 0, height: 40))
        
        infoText.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        bottom: nil,
                        leading: view.leadingAnchor,
                        trailing: view.trailingAnchor,
                        padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                        size: .init(width: 0, height: 80))
        
        
        textBox.anchor(top: infoText.bottomAnchor,
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
        
        Jobİnformation.shared.addInfo(key: key, value: textBox.text)
        
        let uniqueID = UUID().uuidString
        let ref = Database.database().reference().child("İs Bilgileri").child(uniqueID)
        instance = Jobİnformation.shared.information
        
        let yeni = JobModel(nameSurname: UserManager.shared.getUserName()!,detail:Jobİnformation.shared.jobDetail ?? "bos" , id: UserManager.shared.getUser().id ?? "0", information: instance)
        let dictionary = yeni.toDictionary()
        
        
        
        ref.setValue(dictionary) { (error, _) in
            if let error = error {
                print("İşlem başarısız oldu: \(error.localizedDescription)")
            } else {
                print("İşlem başarıyla tamamlandı.")
                self.navigationController?.popToRootViewController(animated: true)
            }
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.customizeBackButton()
      
    }
    
    
    
}
