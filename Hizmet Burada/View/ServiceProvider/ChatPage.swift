//
//  Chat.swift
//  Hizmet Burada
//
//  Created by turan on 13.01.2024.
//

import UIKit
import FirebaseDatabaseInternal

class ChatPage:UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Mesajlar
  
    var messageList: [Message] = []
    var receiverID : String?
        
       
    
    
    
    
    
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
    
    
    
        let tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.separatorStyle = .none
            tableView.allowsSelection = false
            return tableView
        }()
        
        // Mesaj giriş alanı
    let messageInputView: UITextField = {
           let textField = UITextField()
           textField.translatesAutoresizingMaskIntoConstraints = false
           textField.placeholder = "Mesajınızı buraya yazın..."
           textField.borderStyle = .roundedRect
           textField.layer.cornerRadius = 16
           textField.clipsToBounds = true
           textField.backgroundColor = .systemYellow

           let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
           imageView.image = UIImage(systemName: "plus.message.fill") // İstediğiniz ikonu
           imageView.tintColor = .gray
            
        
           return textField
       }()
        
        // Gönderme butonu
    let sendButton: UIButton = {
           let button = UIButton()
           button.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
           button.translatesAutoresizingMaskIntoConstraints = false
           let iconImageView = UIImageView(image: UIImage(systemName: "paperplane.circle.fill"))
           iconImageView.tintColor = .systemYellow
           button.addSubview(iconImageView)
           iconImageView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               iconImageView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
               iconImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
               iconImageView.widthAnchor.constraint(equalToConstant: 56),
               iconImageView.heightAnchor.constraint(equalToConstant: 56)
           ])
 
          
           
           return button
       }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            
            // TableView konfigürasyonu
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(Chat.self, forCellReuseIdentifier: Chat.identifier)
            
            // Gönderme butonuna eylem ekleme
            sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
            
            // View'e elemanları ekleme
            view.addSubview(tableView)
            view.addSubview(messageInputView)
            view.addSubview(sendButton)
            view.addSubview(imageProfile)
            view.addSubview(nameSurnameText)
            getMessage()
            
            
            
            desing()
          
            
        }
    
    
    func desing(){
        
        
        imageProfile.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 6, left: 12, bottom: 0, right: 0),size: .init(width: 44, height: 44))
        
        nameSurnameText.anchor(top: imageProfile.topAnchor, bottom: imageProfile.bottomAnchor, leading: imageProfile.trailingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        
        
        
        tableView.anchor(top: imageProfile.bottomAnchor, bottom: messageInputView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        messageInputView.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: sendButton.leadingAnchor,padding: .init(top: 0, left: 16, bottom: 8, right: 12), size: .init(width: 0, height: 44))
        
        
        sendButton.anchor(top: messageInputView.topAnchor, bottom: messageInputView.bottomAnchor, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 12),
                          size: .init(width: 56, height: 56)
        )
        
    }
    
    
    
    
        
        // Gönderme butonuna tıklandığında çağrılan metod
        @objc func sendButtonTapped() {
         
        }
        
        // TableViewDelegate ve TableViewDataSource metodları
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messageList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: Chat.identifier, for: indexPath) as! Chat
            
            
            cell.messageLabelSend.text = messageList[indexPath.row].text
            cell.messageLabelRecaiver.text = messageList[indexPath.row].text
       
            if UserManager.shared.getUser().id == messageList[indexPath.row].senderID {
                cell.messageLabelSend.isHidden = false
                cell.messageLabelRecaiver.isHidden = true
                
                
            }
            else {
                
                cell.messageLabelSend.isHidden = true
                cell.messageLabelRecaiver.isHidden = false
                
            }
  
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 36  // Örnek: Hücre yüksekliği 80 piksel
        }
    
    
    
    
    
    @objc func loginClick(click :UIButton!){
        
        messageList.removeAll()
        tableView.reloadData()
        
        let currentDate = Date()
        let timestamp = currentDate.timeIntervalSince1970
        
        
        pushMessage(a: Message(senderID: UserManager.shared.getUser().id ?? "", receiverID:receiverID ?? "", text: messageInputView.text ?? "", timestamp: timestamp, price: ""))
        messageInputView.text = ""
       
        
        
        }
    
    
    
    func getMessage(){
        
        let ref = Database.database().reference().child("mesajlar")
    
        ref.observe(.value, with: { snapshot in
            
                self.messageList.removeAll()
                self.tableView.reloadData()
         
            if let value = snapshot.value as? [String: Any] {
               
                for (_,data) in value {
                    
                    if let veri = (data as? [String: Any]) {
                        
    
                        let message = Message(senderID: veri["senderID"] as! String, receiverID: veri["receiverID"] as! String, text: veri["text"] as! String, timestamp: veri["timestamp"] as! Double, price: veri["price"] as! String)
                        
                        self.messageList.append(message)
                        self.tableView.reloadData()
             
                        
                               }
                }
                
    
                      self.messageList.sort { $0.timestamp < $1.timestamp }
                      self.tableView.reloadData()
        
                   }
        }) { (error) in
            print("Error: \(error.localizedDescription)")
        }
        
        
        
    }
        
        
    
    func pushMessage(a :Message){
        
        messageList.removeAll()
        tableView.reloadData()
        
        let currentDate = Date()
        let timestamp = currentDate.timeIntervalSince1970
        let timestampString = String(format: "%.0f", timestamp)
        
        _ = UUID().uuidString
        
        let ref = Database.database().reference().child("mesajlar").child(timestampString)
     
        ref.updateChildValues(a.toDictionarym()) { (error, _) in
            if let error = error {
                print("İşlem başarısız oldu: \(error.localizedDescription)")
            } else {
                
            
             
            }
        }
        
        
        
        
    }
    
    
    
        
        
        
        
    }
    
    
    
    

    
