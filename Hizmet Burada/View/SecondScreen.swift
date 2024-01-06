
import UIKit

class SplashScreen2: UIViewController {
    

    
    lazy var infoText1:UITextView = {
        let infoText1 = UITextView()
   
        infoText1.textColor = .black
        infoText1.textAlignment = .center
        infoText1.text = "Kolayca Hizmet Bul, Hemen Hizmet Ver: Mobil Uygulamamız ile İhtiyaçlarınızı Anında Karşılayın!"
        infoText1.font = UIFont(name: "Verdana", size: 12)
        infoText1.isEditable = false
        return infoText1
    }()
    
    lazy var logo:UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "paint-roller-24246")
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
 
    

    lazy var Btn1: UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("Hizmet Al", for: .normal)
        loginBtn.backgroundColor = .black
        loginBtn.setTitleShadowColor(.white, for: .focused)
        loginBtn.addTarget(self, action: #selector(getservice), for: .touchUpInside)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.setTitleColor(.red, for: .highlighted)
        loginBtn.isEnabled = true
        loginBtn.layer.cornerRadius = 12
        loginBtn.layer.borderWidth = 1.0
        loginBtn.layer.borderColor = UIColor.white.cgColor
        
        return loginBtn
    }()
    lazy var Btn2:UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("Hizmet Ver", for: .normal)
        loginBtn.backgroundColor = .systemYellow
        loginBtn.setTitleShadowColor(.white, for: .focused)
        loginBtn.addTarget(self, action: #selector(serve), for: .touchUpInside)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.setTitleColor(.red, for: .highlighted)
        loginBtn.isEnabled = true
        loginBtn.layer.cornerRadius = 12
        loginBtn.layer.borderWidth = 1.0
        loginBtn.layer.borderColor = UIColor.white.cgColor
        return loginBtn
    }()
    
    lazy var containerTop:UIView = {
        let containerTop = UIView()
        containerTop.backgroundColor = .white
        return containerTop
    }()

   

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(containerTop)
        containerTop.addSubview(Btn1)
        containerTop.addSubview(Btn2)
        containerTop.addSubview(infoText1)
        containerTop.addSubview(logo)
        desing()

    }
    
    
    func desing(){
        
        logo.anchor(top: containerTop.topAnchor, bottom: infoText1.topAnchor, leading: containerTop.leadingAnchor, trailing: containerTop.trailingAnchor,padding: .init(top: 100, left: 100, bottom: 0, right: 100),size: .init(width: 0, height: 0))
        
        Btn1.anchor(top: nil, bottom: Btn2.topAnchor, leading: nil, trailing: nil,padding: .init(top: 0, left: 0, bottom: 12, right: 0),size: .init(width: 300, height: 40))
        Btn1.centerXAnchor.constraint(equalTo: containerTop.centerXAnchor).isActive = true
       
        
        
        Btn2.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: Btn1.leadingAnchor, trailing: Btn1.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 0),size: .init(width: 0, height: 40))
        
        
        infoText1.anchor(top: nil, bottom: Btn1.topAnchor, leading: Btn1.leadingAnchor, trailing: Btn1.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 5, right: 0),size: .init(width: 0, height: 60))

        
        
        containerTop.anchor(top: view.topAnchor,
                         bottom: view.bottomAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor)
       
    }
    


    @objc func getservice(click : UIButton!){
        let tabBar = TabBar()
        self.navigationController?.pushViewController(tabBar, animated: true)
    }
    @objc func serve(click : UIButton!){
        let tabBar = TabBar2()
        self.navigationController?.pushViewController(tabBar, animated: true)
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
