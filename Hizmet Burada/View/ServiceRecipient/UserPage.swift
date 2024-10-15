//
//  Accountİnformation.swift
//  Hizmet Burada
//
//  Created by turan on 18.11.2023.
//

import UIKit

import Firebase

class UserPage: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    var sehirler: [Sehir] = []
    var ilceler: [String] = []
    var selectedSehir: String?
    
    lazy var sehirDropdown: UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.cornerRadius = 5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true  // Başlangıçta gizli
        return tableView
    }()
    
    
    lazy var ilceDropdown: UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.cornerRadius = 5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true  // Başlangıçta gizli
        return tableView
    }()
  
    
    let userModel:User = {
        let model = UserManager.shared.getUser()
        return model
    }()
    
    lazy var container:UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var info:UILabel = {
        let info = UILabel()
        info.backgroundColor = UIColor.clear
        info.font = UIFont(name: "Avenir-Medium", size: 20)
        info.text = "Hesap Bilgilerim"
        return info
    }()
    
    lazy var nameSurname:UITextField = {
        let nameSurname = UITextField()
        let label = UILabel(frame: CGRect(x: 0, y: -30, width: 300, height: 30))
        nameSurname.text = userModel.nameSurname
        nameSurname.borderStyle = .roundedRect
        nameSurname.keyboardType = .emailAddress
        nameSurname.font = UIFont(name: "Avenir", size: 16)
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        label.text = "Ad Soyad"
        nameSurname.addSubview(label)
        return nameSurname
    }()
    

    
    lazy var mail:UITextField = {
        let mail = UITextField()
        let label = UILabel(frame: CGRect(x: 0, y: -30, width: 300, height: 30))
        mail.text =  userModel.email
        mail.borderStyle = .roundedRect
        mail.keyboardType = .emailAddress
        label.text = "E-mail"
        mail.font = UIFont(name: "Avenir", size: 16)
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        mail.addSubview(label)
        mail.isUserInteractionEnabled = false
        return mail
    }()
    
    
    lazy var gsm:UITextField = {
        let gsm = UITextField()
        let label = UILabel(frame: CGRect(x: 0, y: -30, width: 300, height: 30))
        gsm.text = userModel.gsm
        gsm.borderStyle = .roundedRect
        gsm.keyboardType = .emailAddress
        label.text = "Telefon numarası"
        gsm.font = UIFont(name: "Avenir", size: 16)
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        gsm.addSubview(label)
        return gsm
    }()
    
    
    lazy var location1:UITextField = {
        let location = UITextField()
        let label = UILabel(frame: CGRect(x: 0, y: -30, width: 300, height: 30))
        location.placeholder = "Şehir"
        location.borderStyle = .roundedRect
        location.keyboardType = .emailAddress
        label.text = "İl / İlçe / Mahalle"
        location.font = UIFont(name: "Avenir", size: 16)
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        location.delegate = self
        location.addSubview(label)
        return location
    }()
    
    lazy var location2:UITextField = {
        let location2 = UITextField()
        location2.placeholder = "ilçe"
        location2.borderStyle = .roundedRect
        location2.font = UIFont(name: "Avenir", size: 16)
        location2.keyboardType = .emailAddress
        location2.delegate = self
        return location2
    }()
    
    lazy var location3:UITextField = {
        let location3 = UITextField()
        location3.placeholder = "Mahalle"
        location3.font = UIFont(name: "Avenir", size: 16)
        location3.borderStyle = .roundedRect
        location3.keyboardType = .emailAddress
        return location3
    }()
    
    lazy var SaveButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Güncelle", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        return button
    }()
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.customizeBackButton()
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSehirler()
        adress()
        view.backgroundColor = .white
        view.addSubview(container)
        container.addSubview(info)
        container.addSubview(nameSurname)
        container.addSubview(mail)
        container.addSubview(gsm)
        container.addSubview(location1)
        container.addSubview(sehirDropdown)
        container.addSubview(ilceDropdown)
        container.addSubview(location2)
        container.addSubview(location3)
        container.addSubview(SaveButton)
        desing()
    }
    
    
    
    
    func adress (){
        
        let parcalar = userModel.adress?.components(separatedBy: "/")

        // Sonuçları kontrol et
        if parcalar?.count == 3 {
            let il = parcalar?[0]
            location1.text = il
            let ilce = parcalar?[1]
            location2.text = ilce
            let mahalle = parcalar?[2]
            location3.text = mahalle
            print("İl: \(il), İlçe: \(ilce), Mahalle: \(mahalle)")
        } else {
            print("Beklenen formatta bir adres değil.")
        }
        
        
        
    }

    func desing(){
        
        container.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         bottom: view.bottomAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 40, left: 30,
                                        bottom: 0, right: 30))
        info.anchor(top: container.topAnchor,
                    bottom: nil, leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    size: .init(width: 0, height: 40))
        
        nameSurname.anchor(top: info.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 50, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
  
        
        mail.anchor(top: nameSurname.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 50, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        gsm.anchor(top: mail.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 50, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        location1.anchor(top: gsm.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 50, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        
        sehirDropdown.anchor(top: location1.bottomAnchor,
                             bottom: nil,
                               leading: location1.leadingAnchor,
                               trailing: location1.trailingAnchor,
                               size: .init(width: 0, height: 200))
        
        location2.anchor(top: location1.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 5, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        ilceDropdown.anchor(top: location2.bottomAnchor,
                            bottom: nil,
                                   leading: location2.leadingAnchor,
                                   trailing: location2.trailingAnchor,
                                   size: .init(width: 0, height: 200))
        location3.anchor(top: location2.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 5, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        SaveButton.anchor(top: location3.bottomAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 10, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
    }
    

    @objc func buttonClicked() {
            print("Button Clicked!")
        let id = UserManager.shared.getUser().id
        
        let adress = (self.location1.text ?? "") + "-" + (self.location2.text ?? "") + "-" + (self.location3.text ?? "")
        
        let user = User(nameSurname: self.nameSurname.text, gsm: self.gsm.text, email: self.mail.text, id: id, status: "Recipient",adress: adress)
        UserManager.shared.setUser(user: user)
        
        FirestoreManager().UserRecipientPush(user: user) { result in
                switch result {
                case .success(let message):
                    print(message)
                    UserManager.shared.setUser(user: user)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        print(Date())
                        
                        print("Kullanıcı başarıyla kaydedildi")
                        self.navigationItem.title = ""
                        self.navigationController?.isNavigationBarHidden = true
                        self.navigationController?.pushViewController(LoginPage(), animated: true)
                    }

                case .failure(let error): break
                   
        
               
                    
                }
            }
      
        _ = navigationController?.popToRootViewController(animated: true)
        }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == location1 {
            container.bringSubviewToFront(sehirDropdown)
            sehirDropdown.isHidden = false  // Şehir listesi gösteriliyor
            textField.resignFirstResponder()  // Klavyeyi kapatıyoruz
        } else if textField == location2 {
            if let selectedSehir = selectedSehir {
                container.bringSubviewToFront(ilceDropdown)
                ilceDropdown.isHidden = false  // İlçe listesi gösteriliyor
            }
            textField.resignFirstResponder()  // Klavyeyi kapatıyoruz
        }
    }
    
 
    func fetchSehirler() {
        let ref = Database.database().reference()
        
        ref.child("sehirler").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                print("Veri formatı hatalı.")
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Sehir].self, from: jsonData)
                self.sehirler = decodedData
                
                self.sehirDropdown.reloadData()
            } catch let error {
                print("Veri çözümleme hatası: \(error.localizedDescription)")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == sehirDropdown {
            return sehirler.count
        } else if tableView == ilceDropdown {
            return ilceler.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if tableView == sehirDropdown {
            cell.textLabel?.text = sehirler[indexPath.row].il
        } else if tableView == ilceDropdown {
            cell.textLabel?.text = ilceler[indexPath.row]
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == sehirDropdown {
            // Şehir seçildiğinde ilçe dropdown'u gösterilir
            selectedSehir = sehirler[indexPath.row].il
            location1.text = selectedSehir
            ilceler = sehirler[indexPath.row].ilceleri
            ilceDropdown.reloadData()
            sehirDropdown.isHidden = true  // Şehir dropdown'u gizlenir
        } else if tableView == ilceDropdown {
            // İlçe seçildiğinde ilçe dropdown'u gizlenir
            location2.text = ilceler[indexPath.row]
            ilceDropdown.isHidden = true
        }
    }



}
