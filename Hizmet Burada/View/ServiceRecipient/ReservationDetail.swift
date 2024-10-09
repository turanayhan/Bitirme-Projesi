//
//  ReservationDetail.swift
//  Hizmet Burada
//
//  Created by turan on 30.11.2023.
//

import UIKit
import Firebase

class ReservationDetail: UIViewController ,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UITextViewDelegate {
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
    
    
    lazy var location1:UITextField = {
        let location = UITextField()
        let label = UILabel(frame: CGRect(x: 0, y: -30, width: 300, height: 30))
        location.placeholder = "Şehir"
        location.borderStyle = .roundedRect
        location.keyboardType = .emailAddress
        label.text = "Nerede?(hizmetin yapılacağı yer)"
        label.textColor = .systemYellow
        location.textColor = .systemYellow
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
        location2.textColor = .systemYellow
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
        location3.textColor = .systemYellow
        location3.keyboardType = .emailAddress
        return location3
    }()
    
    
    
    
    
    
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
        fetchSehirler()
        adress()
        key = infoText.text.replacingOccurrences(of: "?", with: "")
        Jobİnformation.shared.addInfo(key: key, value: textBox.text)
        
        view.addSubview(location1)
        view.addSubview(sehirDropdown)
        view.addSubview(ilceDropdown)
        view.addSubview(location2)
        view.addSubview(location3)
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
        
        view.backgroundColor = .white
        view.addSubview(nextButton)
        view.addSubview(infoText)
        view.addSubview(textBox)
        
        
        
        
        location1.anchor(top: textBox.bottomAnchor,
                    bottom: nil,
                    leading: textBox.leadingAnchor,
                    trailing: textBox.trailingAnchor,
                    padding: .init(top: 50, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        
        sehirDropdown.anchor(top: location1.bottomAnchor,
                             bottom: nil,
                               leading: location1.leadingAnchor,
                               trailing: location1.trailingAnchor,
                               size: .init(width: 0, height: 200))
        
        location2.anchor(top: location1.bottomAnchor,
                    bottom: nil,
                    leading: textBox.leadingAnchor,
                    trailing: textBox.trailingAnchor,
                    padding: .init(top: 5, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        ilceDropdown.anchor(top: location2.bottomAnchor,
                            bottom: nil,
                                   leading: location2.leadingAnchor,
                                   trailing: location2.trailingAnchor,
                                   size: .init(width: 0, height: 200))
        location3.anchor(top: location2.bottomAnchor,
                    bottom: nil,
                    leading: textBox.leadingAnchor,
                    trailing: textBox.trailingAnchor,
                    padding: .init(top: 5, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        
        
        
        
        nextButton.anchor(top: location3.bottomAnchor,
                          bottom: nil,
                          leading: textBox.leadingAnchor,
                          trailing: textBox.trailingAnchor,
                          padding: .init(top: 10, left: 0, bottom: 0, right: 0),
                          size: .init(width: 0, height: 40))
        
        infoText.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        bottom: nil,
                        leading: view.leadingAnchor,
                        trailing: view.trailingAnchor,
                        padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                        size: .init(width: 0, height: 50))
        
        
        textBox.anchor(top: infoText.bottomAnchor,
                       bottom: nil,
                       leading: view.leadingAnchor,
                       trailing: view.trailingAnchor,
                       padding: .init(top: 12, left: 20, bottom: 0, right: 20),
                       size: .init(width: 0, height: 120))
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == location1 {
            view.bringSubviewToFront(sehirDropdown)
            sehirDropdown.isHidden = false  // Şehir listesi gösteriliyor
            textField.resignFirstResponder()  // Klavyeyi kapatıyoruz
        } else if textField == location2 {
            if let selectedSehir = selectedSehir {
                view.bringSubviewToFront(ilceDropdown)
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
        // Text alanlarının boş olup olmadığını kontrol ediyoruz
        guard let location1Text = location1.text, !location1Text.isEmpty,
              let location2Text = location2.text, !location2Text.isEmpty,
              let location3Text = location3.text, !location3Text.isEmpty,
              let textBoxText = textBox.text, !textBoxText.isEmpty, textBoxText != "Ekstra bilgileri girin..." else {
            
            // Eğer herhangi bir alan boşsa uyarı mesajı gösteriyoruz
            let alert = UIAlertController(title: "Eksik Bilgi", message: "Lütfen tüm alanları doldurun.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Jobİnformation.shared.addInfo(key: key, value: textBox.text)
        let user = UserManager.shared.getUser()
        let uniqueID = UUID().uuidString
        let ref = Database.database().reference().child("Jobs").child(user.id ?? "0")
        instance = Jobİnformation.shared.information
        
       
        
        let yeni = JobModel(nameSurname: user.nameSurname!,detail:Jobİnformation.shared.jobDetail ?? "bos" , id: user.id!, information: instance)
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
