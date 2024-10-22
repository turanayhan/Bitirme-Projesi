//
//  Login.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//

import UIKit
import Firebase
import JGProgressHUD

class LoginPage: UIViewController, UITextFieldDelegate {
    
    var status : String?
    
    
    
    lazy var progresBar: JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.textLabel.text = "Giriş Yapılıyor"
        return progresBar
    }()
    
    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "rb_1835")
        logo.contentMode = .scaleAspectFit
        logo.backgroundColor = UIColor(hex: "#F1FAFE")
        return logo
    }()
    
    lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 9
        return stackView
    }()
    
    lazy var mail: UITextField = {
        let mail = UITextField()
        mail.placeholder = "E-mail"
        mail.borderStyle = .roundedRect
        mail.keyboardType = .emailAddress // Use email keyboard
        
        mail.setPadding(left: 8, right: 0, top: 0, bottom: 0)
        mail.tintColor = UIColor(hex: "40A6F8")
        mail.font = UIFont(name: "Avenir", size: 15)
        mail.borderStyle = .none // Remove default border style
        mail.layer.borderWidth = 0.6 // Sınır kalınlığı
        mail.layer.borderColor = UIColor(hex: "40A6F8").cgColor // İstediğiniz renk
        mail.layer.cornerRadius = 5//
        
        mail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return mail
    }()
    
    
    lazy var password: UITextField = {
        let password = UITextField()
        password.placeholder = "Şifreni gir"
        password.borderStyle = .roundedRect
        
        password.isSecureTextEntry = true
        password.addTarget(self, action: #selector(textFieldDidChanges), for: .editingChanged)
        password.setPadding(left: 8, right: 0, top: 0, bottom: 0)
        password.tintColor = UIColor(hex: "40A6F8")
        password.font = UIFont(name: "Avenir", size: 15)
        password.borderStyle = .none // Varsayılan sınır stilini kaldır
        password.layer.borderWidth = 0.6 // Sınır kalınlığı
        password.layer.borderColor = UIColor(hex: "40A6F8").cgColor // İstediğiniz renk
        password.layer.cornerRadius = 5//
        return password
    }()
    
    lazy var loginBtn:UIButton = {
        

  
       
    
      
        let loginBtn = UIButton()
        loginBtn.setTitle("Giriş Yap", for: .normal)
        loginBtn.backgroundColor = UIColor(hex: "#40A6F8")
        loginBtn.setTitleShadowColor(.white, for: .focused)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.setTitleColor(UIColor(hex: "E3F2FD"), for: .normal)
        loginBtn.setTitleColor(.white, for: .highlighted)
        loginBtn.isEnabled = true
        loginBtn.layer.cornerRadius = 4
        loginBtn.isEnabled = false
        loginBtn.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        return loginBtn
    }()
    lazy var passwordToggleBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal) // Default to 'hide'
        button.tintColor = UIColor(hex: "40A6F8")
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    lazy var passwordBtn:UIButton = {
        let registerBtn = UIButton()
        registerBtn.setTitle("Şifremi unuttum", for: .normal)
        registerBtn.backgroundColor = UIColor(hex: "#F1FAFE")
        registerBtn.setTitleShadowColor(.white, for: .focused)
        registerBtn.addTarget(self, action: #selector(passwordtBtnClick), for: .touchUpInside)
        registerBtn.setTitleColor(UIColor(hex: "40A6F8"), for: .normal)
        registerBtn.setTitleColor(.white, for: .highlighted)
        registerBtn.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        registerBtn.isEnabled = true
        return registerBtn
    }()
    
    override func viewWillAppear(_ animated: Bool) {

        view.backgroundColor = UIColor(hex: "#F1FAFE")
      
    }
    

    override func viewDidLoad() {
        setupCustomBackButton(with: "")
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        stackView.addArrangedSubview(mail)
        stackView.addArrangedSubview(password)
        view.addSubview(stackView)
        view.addSubview(loginBtn)
        view.addSubview(logo)
        view.addSubview(passwordBtn)
        mail.delegate = self

        

        desing()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
    }
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let bottomSpace = view.frame.height - (loginBtn.frame.origin.y + loginBtn.frame.height)
        
        if bottomSpace < keyboardHeight {
            view.frame.origin.y = 0 - (keyboardHeight - bottomSpace + 40) // Ekranı klavye kadar yukarı kaydır
        }
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        view.frame.origin.y = 0 // Görünümü eski konumuna getir
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    func desing(){
        
        let screenWidth = UIScreen.main.bounds.width
        
        logo.anchor(top: nil,
                    bottom: stackView.topAnchor,
                    leading: nil,
                    trailing: nil,
                    padding: .init(top: 12, left: 12, bottom: 16, right: 12), size: .init(width: screenWidth*0.60, height: screenWidth*0.60))
        
        
        logo.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        
        stackView.anchor(top: nil,
                         bottom: nil,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 36, bottom: 0, right: 36),
                         size: .init(width: 0, height: 80))
        
        stackView.centerAnchor()
        
        loginBtn.anchor(top: stackView.bottomAnchor,
                        bottom: nil,
                        leading: stackView.leadingAnchor,
                        trailing: stackView.trailingAnchor,
                        padding: .init(top: 12, left: 0, bottom: 0, right: 0))

        // Adjust password field's right view
        password.rightView = passwordToggleBtn
        password.rightViewMode = .always
        passwordToggleBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30) // Set button size
        passwordToggleBtn.translatesAutoresizingMaskIntoConstraints = false

        
        passwordBtn.anchor(top: loginBtn.bottomAnchor,
                           bottom: nil, leading: loginBtn.leadingAnchor,
                           trailing: loginBtn.trailingAnchor,
                           padding: .init(top: 12, left: 12, bottom: 0, right: 12)
                           )
        
        password.centerXAnchor.constraint(equalTo: loginBtn.centerXAnchor).isActive = true
        
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    

    @objc func loginClick(click : UIButton!){
        progresBar.show(in: self.view)
        
        print("firebase işlemleri")
        
        
        FirestoreManager().signIn(withEmail: self.mail.text ?? "", password: self.password.text ?? "") { [weak self] result in
               guard let self = self else { return }

               switch result {
               case .success(let authResult):
                   print("Giriş başarılı")
                   self.progresBar.dismiss(afterDelay: 2.0)
                   UserManager.shared.isLogin()
                   
                   
                   if status == "Recipient" {
                       self.navigationController?.pushViewController(ServiceRecipient(), animated: true)
                       
                   }
                   
                   else if status == "Provider" {
                       self.navigationController?.pushViewController(ServiceProvider(), animated: true)
                       
                   }
                   
           
                   self.navigationController?.isNavigationBarHidden = true
               case .failure(let error):
                   self.progresBar.dismiss(afterDelay: 2.0)
                   showAlert(title: "Hata", message: error.localizedDescription)

                   print("Giriş hatası: \(error.localizedDescription)")
               }
           }
    }
    

    @objc func passwordtBtnClick(click : UIButton!){
        navigationController?.pushViewController(PasswordResetPage(), animated: true)

        print("şifremi unuttum")
    }
    
    @objc func textFieldDidChanges(textField: UITextField) {
        if  mail.text!.isEmpty || password.text!.isEmpty {
            loginBtn.isEnabled = false
            loginBtn.alpha = 0.5
        } else {
            loginBtn.isEnabled = true
            loginBtn.alpha = 1
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == mail {
            // Validate email format
            if let email = textField.text, !isValidEmail(email) {
                print("Invalid email format")
            }
        }
    }
    // Function to validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss keyboard
        return true
    }
    
    @objc func togglePasswordVisibility() {
        password.isSecureTextEntry.toggle() // Toggle visibility
        let buttonImage = password.isSecureTextEntry ? "eye.slash" : "eye" // Change icon based on state
        passwordToggleBtn.setImage(UIImage(systemName: buttonImage), for: .normal)
    }

    
    func sendPasswordReset(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                // Hata durumunu işleme
                print("Şifre sıfırlama e-posta gönderilemedi: \(error.localizedDescription)")
            } else {
                // Şifre sıfırlama e-postası başarıyla gönderildi
                print("Şifre sıfırlama e-postası gönderildi!")
            }
        }
    }
    
    
}
