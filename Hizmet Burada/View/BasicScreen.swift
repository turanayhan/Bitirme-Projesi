//
//  LoginBasic.swift
//  Hizmet Burada
//
//  Created by turan on 16.10.2024.
//

import UIKit

class BasicScreen: UIViewController {
    
    var status : String?

    lazy var infoText1: UITextView = {
        let infoText1 = UITextView()
        infoText1.textColor = .black
        infoText1.backgroundColor = .clear
        infoText1.textAlignment = .center
        infoText1.text = ""
        infoText1.font = UIFont(name: "Avenir", size: 11)
        infoText1.isEditable = false
        return infoText1
    }()


    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "de")
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true // Taşmayı engelle
        return logo
    }()


    lazy var Btn1: UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("Giriş Yap", for: .normal)
        loginBtn.backgroundColor = UIColor(hex: "#40A6F8")
        loginBtn.setTitleShadowColor(.white, for: .focused)
        loginBtn.addTarget(self, action: #selector(getservice), for: .touchUpInside)
        loginBtn.setTitleColor(UIColor(hex: "E3F2FD"), for: .normal)
        loginBtn.setTitleColor(.white, for: .highlighted)
        loginBtn.isEnabled = true
        loginBtn.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        loginBtn.layer.cornerRadius = 4
        return loginBtn
    }()
    
  

    lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-medium", size: 11)
        
        let fullText = "Hesabın yok mu? KAYIT OL"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // "Kayıt ol" kısmını altı çizgili yapalım
        let range = (fullText as NSString).range(of: "KAYIT OL")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#40A6F8"), range: range) // Renk ekleyelim
        
        label.attributedText = attributedString
        label.isUserInteractionEnabled = true // Dokunma işlemi için gerekli
        
        // Dokunma tanıyıcı ekleyelim
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(registerTapped))
        label.addGestureRecognizer(tapGesture)
        
        return label
    }()

    lazy var containerTop: UIView = {
        let containerTop = UIView()
        view.backgroundColor = UIColor(hex: "#F1FAFE")
        return containerTop
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.addSubview(containerTop)
        containerTop.addSubview(Btn1)
        containerTop.addSubview(registerLabel)
        containerTop.addSubview(infoText1)
        containerTop.addSubview(logo)
        desing()
        Btn1.transform = CGAffineTransform(translationX: -view.frame.width, y: 0)
        registerLabel.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        infoText1.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        logo.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = UIColor(hex: "#F1FAFE")
        setupCustomBackButton()
        
        

     
        UIView.animate(withDuration: 1.0, delay: 0.3, options: .curveEaseInOut, animations: {
            self.Btn1.transform = .identity
            self.registerLabel.transform = .identity
        }, completion: nil)

        // infoText1'i aşağıdan yukarı kaydırma animasyonu
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
            self.infoText1.transform = .identity // Normale dönecek (ekran ortasına gelecek)
        }, completion: nil)

        // logo'yu büyütme animasyonu
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
            self.logo.transform = .identity // Logo eski boyutuna gelecek (normal boyut)
        }, completion: nil)
    }
    
    func setupCustomBackButton() {
          let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
          backButton.tintColor = .black // Rengi değiştirilebilir
          navigationItem.leftBarButtonItem = backButton
      }
    @objc func backButtonTapped() {
          // Geri gitme işlemi (isteğe bağlı olarak bir uyarı da eklenebilir)
          navigationController?.popViewController(animated: true)
      }

    func desing() {
        let screenWidth = UIScreen.main.bounds.width
        logo.anchor(top: containerTop.topAnchor, bottom: infoText1.topAnchor, leading: containerTop.leadingAnchor, trailing: containerTop.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))

        Btn1.anchor(top: nil, bottom: registerLabel.topAnchor, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 12, right: 0), size: .init(width: screenWidth*0.80, height: 30))
        Btn1.centerXAnchor.constraint(equalTo: containerTop.centerXAnchor).isActive = true

        registerLabel.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: Btn1.leadingAnchor, trailing: Btn1.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: .init(width: 0, height: 30))

        infoText1.anchor(top: nil, bottom: Btn1.topAnchor, leading: Btn1.leadingAnchor, trailing: Btn1.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 0), size: .init(width: 0, height: 50))

        containerTop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }
    
    @objc func registerTapped() {
     
        if status == "Recipient" {
            var view = RecipientName()
            self.navigationController?.pushViewController(view, animated: true)
            
        }
        else if status == "Provider" {
            var view = SelectionPage()
            self.navigationController?.pushViewController(view, animated: true)
            
            
        }
        
      
        }

    @objc func getservice(click: UIButton!) {
        var view = LoginPage()
        view.status = status
        self.navigationController?.pushViewController(view, animated: true)
    }

   

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController != nil {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.navigationBar.tintColor = .black
        }
    }
}
