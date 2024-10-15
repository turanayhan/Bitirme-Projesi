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


class SearchPage: UIViewController,UITableViewDataSource, UITableViewDelegate  {
    
    
    var firebaseService = ServiceManager()
    var categories: [Category] = []
   
    let firestoreManager = FirestoreManager()
    
    lazy var worksTableView: UITableView = {
        let worksTableView = UITableView()
        
        worksTableView.separatorStyle = .none
        
        return worksTableView
    }()
    
    lazy var progresBar:JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        return  progresBar
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.customizeBackButton()
        view.backgroundColor = UIColor(hex: "#F1FAFE")
      
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(worksTableView)
        
   
        worksTableView.translatesAutoresizingMaskIntoConstraints = false
        worksTableView.dataSource = self
        worksTableView.delegate = self
        worksTableView.register(jobVr.self, forCellReuseIdentifier: "re")
        desing()
        firebase()


        
   
        
        
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











    
    
}
