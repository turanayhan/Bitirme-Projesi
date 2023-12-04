//
//  Profile.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//


import UIKit
import Firebase

struct UserProfile{
    
    let id : Int
    let name : String
    
    
}

class Profile: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    
    var userProfile = [UserProfile]()
    
   
    
    lazy var container:UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var containerProfile:UIView = {
        let container = UIView()
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "cell")
           return tableView
       }()
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if navigationController != nil {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationController?.isNavigationBarHidden = true
            }
        if UserManager.shared.isUserLoggedIn(){
            container.isHidden = true
            containerProfile.isHidden = false
        }
        else{
            container.isHidden = false
            containerProfile.isHidden = true
            
        }
        
        nameSurname.text = (UserManager.shared.getUser().name ?? "hata") + "  "+(UserManager.shared.getUser().surname ?? "hata")
        userProfile.append(UserProfile(id: 0, name: "Hesap Bilgileri"))
        userProfile.append(UserProfile(id: 1, name: "Şifre Değiştir"))
        userProfile.append(UserProfile(id: 2, name: "Yardım merkezi"))
        userProfile.append(UserProfile(id: 3, name: "Arkadaşlarına tavsiye et"))
        userProfile.append(UserProfile(id: 4, name: "Hizmet Ver"))
        userProfile.append(UserProfile(id: 5, name: "Çıkış Yap"))
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        desing()
    }
    
    func desing (){
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
        return userProfile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileCell
        
        cell.configure(with: userProfile[indexPath.row])
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch userProfile[indexPath.row].id {
        case 0:
            navigationController?.pushViewController(AccountInformation(), animated: true)
        case 1:
            print("Şifre değiştir")
        case 2:
            print("Arkadaşlarına tavsiye et")
        case 3:
            print("Değerlendir")
        case 4:
            print("Haftanın beşinci günü")
        case 5:
            loguth()
        default:
            break
          
        }
        
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 70// Yükseklik değerini istediğiniz değerle değiştirin
       }

    func loguth(){
        
        do {
            try Auth.auth().signOut()
            
            UserManager.shared.removeUserName()
            print("Geçersiz günwwcw")
            navigationController?.pushViewController(Profile(), animated: true)
                   
               } catch let signOutError as NSError {
                   print("Çıkış yaparken hata oluştu: \(signOutError.localizedDescription)")
               }
           }
    }
