//
//  Search.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import JGProgressHUD
import SideMenu


class SearchPage: UIViewController,UITableViewDataSource, UITableViewDelegate  {
    
    
    var firebaseService = ServiceManager()
    var categories: [Category] = []
   
    let firestoreManager = FirestoreManager()
    
    lazy var worksTableView: UITableView = {
        let worksTableView = UITableView()
        worksTableView.backgroundColor = .clear
        
        worksTableView.separatorStyle = .none
        
        return worksTableView
    }()
    
    lazy var progresBar:JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        return  progresBar
        
    }()
    
    lazy var separatorLine:UIView = {
        
        // Çizgi oluşturma
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray // Çizginin rengini ayarlayın
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        menu()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(worksTableView)
        view.backgroundColor = UIColor(hex: "#F1FAFE")
        worksTableView.translatesAutoresizingMaskIntoConstraints = false
        worksTableView.dataSource = self
        worksTableView.delegate = self
        worksTableView.register(jobVr.self, forCellReuseIdentifier: "re")
        desing()
        firebase()

        self.navigationController?.navigationBar.addSubview(separatorLine)
        NSLayoutConstraint.activate([
            separatorLine.leadingAnchor.constraint(equalTo: self.navigationController!.navigationBar.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: self.navigationController!.navigationBar.trailingAnchor),
            separatorLine.bottomAnchor.constraint(equalTo: self.navigationController!.navigationBar.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 0.3) // Çizgi yüksekliği
        ])
        
    }
    
    func desing (){
        
        worksTableView.anchor(top: view.topAnchor, 
                              bottom: view.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "re", for: indexPath) as! jobVr
        cell.backgroundColor = .clear
        cell.modelic = categories[(indexPath.row)]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 180
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       }
    
    
    func firebase(){
        progresBar.show(in: self.view)
        
        // Firebase'den veriyi çekiyoruz
             firebaseService.fetchCategoryData { [weak self] categories in
                 guard let self = self else { return }
                 if let categories = categories {
                     self.categories = categories
                     // Veriyi işleyip ekranda göster
                     self.categories = categories
                     self.worksTableView.reloadData()
                     self.progresBar.dismiss()
                 } else {
                     print("Veri alınamadı.")
                 }
             }
        
        
       
        
       
        
            
            
        }
    
    
    
    
    
    
    func menu(){
        let menuButton = UIBarButtonItem(
            image: UIImage(systemName: "line.horizontal.3"), // Menü ikonu
            style: .plain,
            target: self,
            action: #selector(openMenu)
        )
        let titleLabel = UILabel()
        titleLabel.text = "Hizmet Burada"
        titleLabel.textColor = .black // Başlık rengi
        titleLabel.font = UIFont(name: "Chalkduster", size: 15)
        titleLabel.textAlignment = .center
        menuButton.tintColor = .black // Simge rengi (isteğe bağlı)
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.titleView = titleLabel
        let menu = SideMenuNavigationController(rootViewController: Menu())
        menu.leftSide = true // Sol taraftan açılacak
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    
        
        
    @objc func openMenu() {
        if let menu = SideMenuManager.default.leftMenuNavigationController {
    
            present(menu, animated: true, completion: nil)
            
        }
        
        

    }











    
    
}