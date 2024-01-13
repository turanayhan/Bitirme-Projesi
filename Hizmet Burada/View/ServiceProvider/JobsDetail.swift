//
//  JobsDetail.swift
//  Hizmet Burada
//
//  Created by turan on 7.01.2024.
//

import UIKit
import FirebaseDatabaseInternal

class JobsDetail: UIViewController ,UITextViewDelegate {

    var modelic : JobModel? {
           didSet {
               
               nameSurnameText.text = modelic?.nameSurname
               jobDetail.text = modelic?.detail
               
               if let information = modelic?.information {
                   var index = 0
                   for (key, value) in information {
                       // Döngü içindeki her çifti ayrı etiketlere ata
                       switch index {
                       case 0:
                           answer1.text = key + " ?"
                           // Eğer değeri de kullanmak istiyorsanız, aynı şekilde answer2.text = value şeklinde ata
                           question1.text = value
                       case 1:
                           answer2.text = key + " ?"
                           // Eğer değeri de kullanmak istiyorsanız, aynı şekilde answer4.text = value şeklinde ata
                           question2.text = value
                           
                       case 2:
                           answer3.text = key + " ?"
                           // Eğer değeri de kullanmak istiyorsanız, aynı şekilde answer4.text = value şeklinde ata
                           question3.text = value
                           
                           
                       case 3:
                           answer4.text = key + " ?"
                           // Eğer değeri de kullanmak istiyorsanız, aynı şekilde answer4.text = value şeklinde ata
                           question4.text = value
                       default:
                           break
                       }
                       index += 1
                   }
               }
              
               }
        
           }
       
    
    
    lazy var scrollView: UIScrollView = {
           let scrollView = UIScrollView()
           scrollView.showsVerticalScrollIndicator = false
           return scrollView
       }()
    
    
    
    lazy var imageProfile:UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(systemName:"person.crop.circle.dashed")
        logo.contentMode = .scaleAspectFill
        logo.tintColor = .systemYellow
     
        return logo
    }()
    
    
    lazy var nameSurnameText:UILabel = {
        let infoText = UILabel()
        infoText.text = "Turan Ayhan"
        infoText.textColor = .black
        infoText.textAlignment = .left
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
       
        
        return infoText
    }()
    
    lazy var jobDetail:UILabel = {
        let infoText = UILabel()
        infoText.text = "Boş Ev Temizliği"
        infoText.textColor = .black
        infoText.textAlignment = .left
        infoText.font = UIFont(name: "Helvetica-Bold", size: 12)
       
        
        return infoText
    }()
    
    
    lazy var textCalender : UITextView = {
        let text = UITextView()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 7, width: 20, height: 20))
        imageView.image = UIImage(systemName:  "calendar")
        imageView.tintColor = .systemYellow
        text.textColor = .black
        text.font = UIFont(name: "Thonburi", size: 12)
        text.isScrollEnabled = false
        text.isEditable = false
        text.text = "     Pazartesi , 15 Ocak - 09:00"
        text.textAlignment = .justified
        text.addSubview(imageView)
        return text
    }()
    lazy var textLocation : UITextView = {
        let text = UITextView()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 7, width: 20, height: 20))
        imageView.image = UIImage(systemName:  "location.fill")
        imageView.tintColor = .systemYellow
        text.textColor = .black
        text.font = UIFont(name: "Thonburi", size: 12)
        text.isScrollEnabled = false
        text.isEditable = false
        text.text = "     Şifa Mah, Battalgazi, Malatya"
        text.textAlignment = .justified
        text.addSubview(imageView)
        return text
    }()
    lazy var textPhone : UITextView = {
        let text = UITextView()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 7, width: 20, height: 20))
        imageView.image = UIImage(systemName:  "phone.fill")
        imageView.tintColor = .systemYellow
        text.textColor = .black
        text.font = UIFont(name: "Thonburi", size: 12)
        text.isScrollEnabled = false
        text.isEditable = false
        text.text = "     Müşteriyi Arayabilirsin"
        text.textAlignment = .justified
        text.addSubview(imageView)
        return text
    }()
    
    lazy var stackView1:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var answer1:UILabel = {
        let answer1 = UILabel()
        answer1.text = "Evin Büyüklüğü nedir?"
        answer1.textColor = .black
        answer1.textAlignment = .left
        answer1.font = UIFont(name: "Helvetica-Bold", size: 12)
        return answer1
    }()
    
    lazy var question1:UILabel = {
        let question1 = UILabel()
        question1.text = "  3+1"
        question1.textColor = .black
        question1.textAlignment = .left
        question1.font = UIFont(name: "Helvetica", size: 12)
        return question1
    }()
    
    lazy var answer2:UILabel = {
        let answer2 = UILabel()
        answer2.text = "Ev Kaç Metrekare?"
        answer2.textColor = .black
        answer2.textAlignment = .left
        answer2.font = UIFont(name: "Helvetica-Bold", size: 12)
        return answer2
    }()
    
    lazy var question2:UILabel = {
        let question2 = UILabel()
        question2.text = "  120"
        question2.textColor = .black
        question2.textAlignment = .left
        question2.font = UIFont(name: "Helvetica", size: 12)
        return question2
    }()
    
    lazy var answer3:UILabel = {
        let answer3 = UILabel()
        answer3.text = "Kaç Banyo?"
        answer3.textColor = .black
        answer3.textAlignment = .left
        answer3.font = UIFont(name: "Helvetica-Bold", size: 12)
        return answer3
    }()
    
    lazy var question3:UILabel = {
        let question3 = UILabel()
        question3.text = "  1"
        question3.textColor = .black
        question3.textAlignment = .left
        question3.font = UIFont(name: "Helvetica", size: 12)
        return question3
    }()
    
    
    lazy var answer4:UILabel = {
        let answer3 = UILabel()
        answer3.text = "İhtiyacın detayları neler?"
        answer3.textColor = .black
        answer3.textAlignment = .left
        answer3.font = UIFont(name: "Helvetica-Bold", size: 12)
        return answer3
    }()
    
    lazy var question4:UILabel = {
        let question3 = UILabel()
        question3.text = "  3+1 Ev temizlenecek eşya yok boş"
        question3.textColor = .black
        question3.textAlignment = .left
        question3.font = UIFont(name: "Helvetica", size: 12)
        return question3
    }()
    
    
    lazy var opportunityText:UILabel = {
        let infoText = UILabel()
        infoText.text = "Teklif Ver"
        infoText.textColor = .black
        infoText.textAlignment = .left
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
        return infoText
    }()
    
    lazy var container : UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
      return container
    }()
    
    lazy var container2 : UIView = {
        let container = UIView()
        container.backgroundColor = .clear
      return container
    }()
    
    lazy var priceText:UILabel = {
        let priceText = UILabel()
        priceText.text = "Fiyat(KDV) dahil)?"
        priceText.textColor = .black
        priceText.textAlignment = .left
        priceText.font = UIFont(name: "Helvetica-Bold", size: 12)
        return priceText
    }()
    
    lazy var priceTextField:UITextField = {
        let gsm = UITextField()
        gsm.borderStyle = .roundedRect
        gsm.placeholder = "TL"
        return gsm
    }()
    
    lazy var chatText:UILabel = {
        let priceText = UILabel()
        priceText.text = "Mesaj"
        priceText.textColor = .black
        priceText.textAlignment = .left
        priceText.font = UIFont(name: "Helvetica-Bold", size: 12)
        return priceText
    }()
    
    
    lazy var textBox:UITextView = {
        let textBox = UITextView(frame: CGRect(x: 50, y: 100, width: 400, height: 300))
        textBox.text = "Müşterinin ihtiyacını anladığını göster. Onun ihtiyacına özel bir fiyat teklifi ver."
        textBox.backgroundColor = .white
        
        textBox.layer.borderWidth = 0.5
        textBox.layer.borderColor = UIColor.lightGray.cgColor
        textBox.layer.cornerRadius = 4.0
        textBox.layer.shadowColor = UIColor.black.cgColor
        textBox.layer.shadowOpacity = 0.1
        textBox.layer.shadowOffset = CGSize(width: 1, height: 1)
        textBox.layer.shadowRadius = 4.0
        textBox.font = UIFont.systemFont(ofSize: 14.0)
        textBox.delegate = self
        return textBox
    }()
    
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Teklif Ver", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 2
        button.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        return button
    }()
    
    var messageList : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(imageProfile)
        scrollView.addSubview(nameSurnameText)
        scrollView.addSubview(jobDetail)
        scrollView.addSubview(stackView1)
        scrollView.addSubview(container)
        scrollView.addSubview(nextButton)
        stackView1.addArrangedSubview(textCalender)
        stackView1.addArrangedSubview(textLocation)
        stackView1.addArrangedSubview(textPhone)
        stackView1.addArrangedSubview(answer1)
        stackView1.addArrangedSubview(question1)
        stackView1.addArrangedSubview(answer2)
        stackView1.addArrangedSubview(question2)
        stackView1.addArrangedSubview(answer3)
        stackView1.addArrangedSubview(question3)
        stackView1.addArrangedSubview(answer4)
        stackView1.addArrangedSubview(question4)
     
        container.addSubview(container2)
        container2.addSubview(opportunityText)
        container2.addSubview(priceText)
        container2.addSubview(priceTextField)
        container2.addSubview(chatText)
        container2.addSubview(textBox)
        desing()
        
        
        
    }
    

    func desing(){
        
        scrollView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        imageProfile.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 12, left: 20, bottom: 0, right: 0),size: .init(width: 44, height: 44))
        
        nameSurnameText.anchor(top: imageProfile.topAnchor, bottom: imageProfile.bottomAnchor, leading: imageProfile.trailingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        
        
        jobDetail.anchor(top: imageProfile.bottomAnchor, bottom: nil, leading: imageProfile.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 8, left: 4, bottom: 0, right: 0),size: .init(width: 0, height: 30))
        
        stackView1.anchor(top: jobDetail.bottomAnchor, bottom: nil, leading: jobDetail.leadingAnchor, trailing: jobDetail.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right:20))
      
        container.anchor(top: stackView1.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 6, left: 0, bottom: 0, right: 0))
     
        container2.anchor(top: container.topAnchor, bottom: container.bottomAnchor, leading: stackView1.leadingAnchor, trailing: view.trailingAnchor)
        
        opportunityText.anchor(top: stackView1.bottomAnchor, bottom: nil, leading: stackView1.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 16, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 30))
        
        priceText.anchor(top: opportunityText.bottomAnchor, bottom: nil, leading: opportunityText.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: 30))
        
        priceTextField.anchor(top: priceText.bottomAnchor, bottom: nil, leading: opportunityText.leadingAnchor, trailing: stackView1.trailingAnchor,size: .init(width: 0, height: 30))
        
        chatText.anchor(top: priceTextField.bottomAnchor, bottom: nil, leading: priceTextField.leadingAnchor, trailing: stackView1.trailingAnchor,padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
        textBox.anchor(top: chatText.bottomAnchor, bottom: nextButton.topAnchor, leading: priceTextField.leadingAnchor, trailing: stackView1.trailingAnchor,padding: .init(top: 16, left: 0, bottom: 6, right: 0))
        
        nextButton.anchor(top: nil,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 10, left: 20, bottom: 30, right: 20),
                          size: .init(width: 0, height: 40))
    }
    
    
    @objc func loginClick(click :UIButton!){
        let currentDate = Date()

        // Şu anki tarih ve saat bilgisini saniye cinsinden al
        let timestamp = currentDate.timeIntervalSince1970

    
        
        var msg = Message(senderID: UserManager.shared.getUser().id!, receiverID: modelic?.id ?? "0", text: textBox.text!, timestamp: timestamp, price: priceTextField.text!)
       
        
        
        messageList.append(msg)
        modelic?.message = messageList

        let uniqueID = UUID().uuidString
        let ref = Database.database().reference().child("teklifler").child(modelic!.id)
        let dictionary = modelic!.toDictionary()
        ref.updateChildValues(dictionary) { (error, _) in
            if let error = error {
                print("İşlem başarısız oldu: \(error.localizedDescription)")
            } else {
                
                
                self.pushMessage(a: msg)
             
            }
        }
        
        
        
        
        
        
    }
    
    
    
    func pushMessage(a :Message){
        
        let currentDate = Date()
        let timestamp = currentDate.timeIntervalSince1970
        let timestampString = String(format: "%.0f", timestamp)
        let uniqueID = UUID().uuidString
        
        let ref = Database.database().reference().child("mesajlar").child(timestampString)
     
        
     
        
        
        
        ref.updateChildValues(a.toDictionarym()) { (error, _) in
            if let error = error {
                print("İşlem başarısız oldu: \(error.localizedDescription)")
            } else {
                
                self.navigationController?.pushViewController(Offer(), animated: true)
             
            }
        }
        
        
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textBox.text == "Müşterinin ihtiyacını anladığını göster. Onun ihtiyacına özel bir fiyat teklifi ver." {
            textBox.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textBox.text.isEmpty {
            textBox.text = "Müşterinin ihtiyacını anladığını göster. Onun ihtiyacına özel bir fiyat teklifi ver."
        }
    }
   

}
