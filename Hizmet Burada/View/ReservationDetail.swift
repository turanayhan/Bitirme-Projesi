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
        
        infoText.font = UIFont.boldSystemFont(ofSize: 20)
        infoText.isEditable = false
        infoText.textAlignment = .center
        infoText.delegate = self
        infoText.text = "Bilmemiz gereken başka hangi detaylar var?"
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
        let key = infoText.text.replacingOccurrences(of: "?", with: "")
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
        if textBox.text == "Uzun bilgi girin..." {
            textBox.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textBox.text.isEmpty {
            textBox.text = "Uzun bilgi girin..."
        }
    }
    
    @objc private func nextButtonTapped() {
        let ref = Database.database().reference().child("İs Bilgileri").child(UserManager.shared.getUser().id ?? "0")
        instance = Jobİnformation.shared.information
        
        ref.setValue(instance) { (error, _) in
            if let error = error {
                print("İşlem başarısız oldu: \(error.localizedDescription)")
            } else {
                print("İşlem başarıyla tamamlandı.")
                self.navigationController?.popToRootViewController(animated: true)
            }
        }

    }

    override func viewWillAppear(_ animated: Bool) {
      
    }
    
}
