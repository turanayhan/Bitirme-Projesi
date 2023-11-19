//
//  Profile.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//


import UIKit
import Firebase

class Profile: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    
    let profileList = ["Hesap bilgilerim", "Şifre değiştir", "Arkadaşlarına tavsiye et, ","Değerlendir", "Yardım merkezi","Veri ve gizlilik","Çıkış Yap"]
    
    let userModel:User = {
        let model = App.shared.userDefaultsManager.getUser()
        return model
    }()
    
    lazy var container:UIView = {
        let container = UIView()
        container.isHidden = App.shared.userDefaultsManager.isUserLoggedIn()
        return container
    }()
    
    lazy var containerProfile:UIView = {
        let container = UIView()
        container.isHidden = !App.shared.userDefaultsManager.isUserLoggedIn()
        return container
    }()
    
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
        registerBtn.backgroundColor = .systemYellow
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
        loginBtn.setTitleColor(.systemYellow, for: .normal)
        loginBtn.setTitleColor(.white, for: .highlighted)
        loginBtn.layer.cornerRadius = 4
        loginBtn.layer.borderColor = UIColor.systemYellow.cgColor
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.layer.borderWidth = 0.8
        return loginBtn
    }()
    
    lazy var imageProfile:UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(systemName:"person.crop.circle.dashed")
        logo.contentMode = .scaleAspectFill
        logo.tintColor = .systemYellow
        return logo
    }()
    
    lazy var nameSurname:UITextView = {
        let nameSurname = UITextView()
        nameSurname.backgroundColor = UIColor.clear
        nameSurname.font = UIFont.boldSystemFont(ofSize: 24)
        nameSurname.isEditable = false
        nameSurname.textAlignment = .center
        nameSurname.text = (userModel.name ?? "hata") + (userModel.surname ?? "hata")
        return nameSurname
    }()
    
    lazy var accountİnformation:UIButton = {
        let accountİnformation = UIButton()
        accountİnformation.setTitle("Giriş Yap", for: .normal)
        accountİnformation.backgroundColor = .red
        accountİnformation.setTitleShadowColor(.white, for: .focused)
        accountİnformation.setTitleColor(.white, for: .normal)
        accountİnformation.setTitleColor(.red, for: .highlighted)
        accountİnformation.isEnabled = true
        accountİnformation.layer.cornerRadius = 4
        return accountİnformation
    }()
    
    lazy var tableView: UITableView = {
           let tableView = UITableView()
           return tableView
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(container)
        view.addSubview(containerProfile)
        containerProfile.addSubview(imageProfile)
        containerProfile.addSubview(nameSurname)
        containerProfile.addSubview(tableView)
        stackView.addArrangedSubview(registerBtn)
        stackView.addArrangedSubview(loginBtn)
        container.addSubview(stackView)
        view.backgroundColor = .white
        container.addSubview(logo)
        container.addSubview(infoText)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "cell")
        desing()
    }
    
    
    
    func desing (){
        
        container.anchor(top: view.topAnchor,
                         bottom: view.bottomAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor)
        
        containerProfile.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         bottom: view.bottomAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor)
        
        imageProfile.anchor(top: containerProfile.topAnchor,
                            bottom: nil,
                            leading: nil,
                            trailing: nil,
                            padding: .init(top: 12, left: 0, bottom: 0, right: 0),
                            size: .init(width: 140, height: 140)
                           )
        imageProfile.centerXAnchor.constraint(equalTo: containerProfile.centerXAnchor).isActive = true
        
        nameSurname.anchor(top: imageProfile.bottomAnchor,
                           bottom: nil,
                           leading: containerProfile.leadingAnchor,
                           trailing: containerProfile.trailingAnchor,
                           size: .init(width: 0, height: 40))
        
        tableView.anchor(top: nameSurname.bottomAnchor,
                         bottom: containerProfile.bottomAnchor,
                         leading: containerProfile.leadingAnchor,
                         trailing: containerProfile.trailingAnchor)
        stackView.anchor(top: nil,
                         bottom: nil,
                         leading: container.leadingAnchor,
                         trailing: container.trailingAnchor,
                         padding: .init(top: 0, left: 32, bottom: 0, right: 32),
                         size: .init(width: 0, height: 90))
        stackView.centerAnchor()
        
        
        logo.anchor(top: view.topAnchor,
                    bottom: infoText.topAnchor,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileCell
        
        cell.configure(with: profileList[indexPath.row])
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch profileList[indexPath.row] {
        case "Hesap bilgilerim":
            navigationController?.pushViewController(AccountInformation(), animated: true)
        case "Şifre değiştir":
            print("Şifre değiştir")
        case "Arkadaşlarına tavsiye et":
            print("Arkadaşlarına tavsiye et")
        case "Değerlendir":
            print("Değerlendir")
        case "Yardım merkezi":
            print("Haftanın beşinci günü")
        case "Veri ve gizlilik":
            print("Haftanın altıncı günü")
        case "Çıkış Yap":
          loguth()
            
        default:
            print("Geçersiz gün")
        }
        
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 70// Yükseklik değerini istediğiniz değerle değiştirin
       }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if navigationController != nil {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationController?.isNavigationBarHidden = true
            }
        }
    
    
    func loguth(){
        
        do {
            try Auth.auth().signOut()
            
            App.shared.userDefaultsManager.removeUserName()
            print("Geçersiz günwwcw")
            navigationController?.pushViewController(Profile(), animated: true)
                   
               } catch let signOutError as NSError {
                   print("Çıkış yaparken hata oluştu: \(signOutError.localizedDescription)")
               }
           }
    }
