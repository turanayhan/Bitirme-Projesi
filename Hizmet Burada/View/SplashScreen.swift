//
//  SplashScreen.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//


import UIKit

class SplashScreen: UIViewController {
    
    private var timer: Timer?
    
    lazy  var stackview : UIStackView = {
        let stackview = UIStackView()
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        return stackview
    }()
    
    lazy var logoText : UITextView = {
        let logoText = UITextView()
        logoText.text = "Hizmet"
        logoText.isEditable = false
        logoText.font = UIFont(name: "Chalkduster", size: 40)
        logoText.textColor = .systemYellow
        logoText.textAlignment = .right
        return logoText
    }()
    
    lazy var logoText2 : UITextView = {
        let logoText2 = UITextView()
        logoText2.text = "Burada"
        logoText2.isEditable = false
        logoText2.font = UIFont(name: "Chalkduster", size: 40)
        logoText2.textColor = .black
        logoText2.textAlignment = .left
        return logoText2
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ekrana geçme fonksiyonu
        
        logoTimer()
        view.backgroundColor = .white
        stackview.addArrangedSubview(logoText)
        stackview.addArrangedSubview(logoText2)
        view.addSubview(stackview)
        desing()
    }
    
    func desing(){
        stackview.anchor(top: nil, bottom: nil, 
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         size: .init(width: 0, height: 60))
        stackview.centerAnchor()
    }
    
    func logoTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 5,
                                         target: self,
                                         selector: #selector(
                                            screenTransition),
                                         userInfo: nil,
                                         repeats: true)
    }

    @objc private func screenTransition() {
        print("ekrana geç...")
        let tabBar = TabBar()
        self.navigationController?.pushViewController(tabBar, animated: true)
        self.timer?.invalidate()
    }
        
    }
