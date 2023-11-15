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


class Search: UIViewController,UITableViewDataSource, UITableViewDelegate  {
    
    
    
    
    
    var listTableView:[ItemModel] = []
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(worksTableView)
        firebase()
        worksTableView.translatesAutoresizingMaskIntoConstraints = false
        worksTableView.dataSource = self
        worksTableView.delegate = self
        worksTableView.register(TableItemVertical.self, forCellReuseIdentifier: "re")
        desing()
        
        
    }
    
    
    func desing (){
        
        worksTableView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "re", for: indexPath) as! TableItemVertical
        
        cell.model = listTableView[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
        
    }
    
    
    
    func firebase(){
        progresBar.show(in: self.view)
        

        firestoreManager.fetchUsers { (worklist, error) in
            
            if let error = error {
                print("Veri çekme hatası: \(error.localizedDescription)")
            } else if let worklist = worklist {
                
                for worklist in worklist {
                    
                    self.listTableView = worklist.veri
                    self.worksTableView.reloadData()
                    self.progresBar.dismiss()
                   
                }
            }
        }
    
       

     
    }
    
    

    
}




struct MyFirestoreData: Codable {
    var header: String
    var itemMethods: [String]

    // Diğer özellikler varsa buraya ekleyebilirsiniz.

    enum CodingKeys: String, CodingKey {
        case header
        case itemMethods
        // Diğer özelliklerin CodingKeys tanımlamaları
    }
}
