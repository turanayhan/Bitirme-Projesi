import UIKit
import FirebaseAuth
import Firebase
import JGProgressHUD

class Register: UIViewController, UITextFieldDelegate {
    
    lazy var progresBar: JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.textLabel.text = "Kaydınız Gerçekleşiyor"
        return progresBar
    }()
    
    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "12144997_Wavy_Cst-01_Single-09")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 9
        return stackView
    }()
    
    lazy var nameSurname: UITextField = {
        let nameSurname = UITextField()
        nameSurname.placeholder = "Ad Soyad"
        nameSurname.setPadding(left: 8, right: 0, top: 0, bottom: 0)
        nameSurname.tintColor = .systemYellow
        nameSurname.font = UIFont(name: "Avenir", size: 15)
        nameSurname.borderStyle = .none // Varsayılan sınır stilini kaldır
        nameSurname.layer.borderWidth = 0.6 // Sınır kalınlığı
        nameSurname.layer.borderColor = UIColor.systemYellow.cgColor // İstediğiniz renk
        nameSurname.layer.cornerRadius = 5// İsteğe bağlı olarak köşe yuvarlama
        nameSurname.keyboardType = .default
        nameSurname.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return nameSurname
    }()
    // Define the maximum character limit for GSM
      let maxGsmCharacters = 10

      lazy var gsm: UITextField = {
          let gsm = UITextField()
          gsm.placeholder = "Telefon Numarası"
          gsm.borderStyle = .roundedRect
          gsm.keyboardType = .numberPad // Allow only numbers
          gsm.returnKeyType = .done // Change the return key type to "Done"
          
          gsm.setPadding(left: 8, right: 0, top: 0, bottom: 0)
          gsm.tintColor = .systemYellow
          gsm.font = UIFont(name: "Avenir", size: 15)
          gsm.borderStyle = .none // Remove default border style
          gsm.layer.borderWidth = 0.6 // Border thickness
          gsm.layer.borderColor = UIColor.systemYellow.cgColor // Desired color
          gsm.layer.cornerRadius = 5
          
          gsm.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
          
          return gsm
      }()

      lazy var mail: UITextField = {
          let mail = UITextField()
          mail.placeholder = "E-mail"
          mail.borderStyle = .roundedRect
          mail.keyboardType = .emailAddress // Use email keyboard
          
          mail.setPadding(left: 8, right: 0, top: 0, bottom: 0)
          mail.tintColor = .systemYellow
          mail.font = UIFont(name: "Avenir", size: 15)
          mail.borderStyle = .none // Remove default border style
          mail.layer.borderWidth = 0.6 // Border thickness
          mail.layer.borderColor = UIColor.systemYellow.cgColor // Desired color
          mail.layer.cornerRadius = 5
          
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
        password.tintColor = .systemYellow
        password.font = UIFont(name: "Avenir", size: 15)
        password.borderStyle = .none // Varsayılan sınır stilini kaldır
        password.layer.borderWidth = 0.6 // Sınır kalınlığı
        password.layer.borderColor = UIColor.systemYellow.cgColor // İstediğiniz renk
        password.layer.cornerRadius = 5//
        return password
    }()
    
    lazy var passwordToggleBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal) // Default to 'hide'
        button.tintColor = .systemYellow
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    lazy var registerBtn: UIButton = {
        let registerBtn = UIButton()
        registerBtn.setTitle("Kayıt Ol", for: .normal)
        registerBtn.backgroundColor = .systemYellow
        registerBtn.setTitleShadowColor(.white, for: .focused)
        registerBtn.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        registerBtn.setTitleColor(.white, for: .normal)
        registerBtn.setTitleColor(.red, for: .highlighted)
        registerBtn.layer.cornerRadius = 4
        registerBtn.isEnabled = false
        registerBtn.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        registerBtn.alpha = 0.5
        return registerBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Kayıt Ol"
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        stackView.addArrangedSubview(nameSurname)
        stackView.addArrangedSubview(gsm)
        stackView.addArrangedSubview(mail)
        stackView.addArrangedSubview(password)
        view.addSubview(stackView)
        view.addSubview(registerBtn)
        view.addSubview(logo)
        design()
        gsm.delegate = self
        mail.delegate = self

        // Add keyboard observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Unified function to handle text changes
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == mail {
            // Validate email format
            if let email = textField.text, !isValidEmail(email) {
                print("Invalid email format")
            }
        } else if textField == gsm {
            print("GSM Number: \(textField.text ?? "")")
        }
    }
    
    // Function to validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    // UITextFieldDelegate method to limit characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // Check character limit for GSM
        if textField == gsm {
            // Ensure only numbers are entered and restrict to 10 characters
            return updatedText.count <= maxGsmCharacters && updatedText.allSatisfy({ $0.isNumber })
        } else if textField == mail {
            // Allow unlimited characters for the email
            return true
        }
        return true
    }

    // To handle "Done" action
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss keyboard
        return true
    }
    

    func design() {
        let screenWidth = UIScreen.main.bounds.width
        
        logo.anchor(top: nil,
                    bottom: stackView.topAnchor,
                    leading: nil,
                    trailing: nil,
                    padding: .init(top: 12, left: 12, bottom: 16, right: 12), size: .init(width: screenWidth*0.50, height: screenWidth*0.50))
        
        logo.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        
        stackView.anchor(top: nil,
                         bottom: nil,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 36, bottom: 0, right: 36),
                         size: .init(width: 0, height: view.frame.height / 5))
        
        stackView.centerAnchor()
        
        // Adjust password field's right view
        password.rightView = passwordToggleBtn
        password.rightViewMode = .always
        passwordToggleBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30) // Set button size
        passwordToggleBtn.translatesAutoresizingMaskIntoConstraints = false

        registerBtn.anchor(top: stackView.bottomAnchor,
                           bottom: nil,
                           leading: stackView.leadingAnchor,
                           trailing: stackView.trailingAnchor,
                           padding: .init(top: 12, left: 0, bottom: 0, right: 0))
    }
    
    @objc func textFieldDidChanges(textField: UITextField) {
        if nameSurname.text!.isEmpty || mail.text!.isEmpty || password.text!.isEmpty {
            registerBtn.isEnabled = false
            registerBtn.alpha = 0.5
        } else {
            registerBtn.isEnabled = true
            registerBtn.alpha = 1
        }
    }
    
    @objc func registerClick(click: UIButton!) {
        progresBar.show(in: self.view)
        
        Auth.auth().createUser(withEmail: self.mail.text!, password: self.password.text!) { response, error in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                self.showAlert(title: "Hata", message: error.localizedDescription)
                self.progresBar.dismiss(afterDelay: 2.0)
                return
            }
            
            let id = UUID().uuidString
            
            let user = User(nameSurname: self.nameSurname.text, gsm: self.gsm.text, email: self.mail.text, id: id, status: "Recipient")

            FirestoreManager().UserRecipientPush(user: user) { result in
                    switch result {
                    case .success(let message):
                        print(message)
                        UserManager.shared.setUser(user: user)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            print(Date())
                            self.progresBar.dismiss(afterDelay: 2.0)
                            print("Kullanıcı başarıyla kaydedildi")
                            self.navigationItem.title = ""
                            self.navigationController?.isNavigationBarHidden = true
                            self.navigationController?.pushViewController(Login(), animated: true)
                        }

                    case .failure(let error):
                       
                        self.progresBar.dismiss(afterDelay: 1.0)
                   
                        
                    }
                }
            
        
        }
    }
    
        
    
    
    @objc func togglePasswordVisibility() {
        password.isSecureTextEntry.toggle() // Toggle visibility
        let buttonImage = password.isSecureTextEntry ? "eye.slash" : "eye" // Change icon based on state
        passwordToggleBtn.setImage(UIImage(systemName: buttonImage), for: .normal)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardSize.cgRectValue
            let bottomInset = keyboardFrame.height
            
            // StackView'in alt kenarının konumunu ayarla
            let stackViewBottom = stackView.frame.origin.y + stackView.frame.height
            
            // Eğer klavye, registerBtn'in üstünde ise ekranı kaydır
            if registerBtn.frame.origin.y + registerBtn.frame.height > view.frame.height - bottomInset {
                let offset = registerBtn.frame.origin.y + registerBtn.frame.height - (view.frame.height - bottomInset) + 20 // 20 bir tampon mesafe
                UIView.animate(withDuration: 0.3) {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -offset)
                }
            }
        }
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
