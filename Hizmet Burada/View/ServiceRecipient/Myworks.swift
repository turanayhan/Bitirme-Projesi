//
//  Myworks.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//

import UIKit
import FirebaseDatabaseInternal

class Myworks: UIViewController ,UITableViewDataSource, UITableViewDelegate {

    
    

    var JobModelList: [JobModel] = []
    var firebaseManager = FirestoreManager()
 
      
      // TableView tanımı
      let tableView: UITableView = {
          let table = UITableView()
          table.translatesAutoresizingMaskIntoConstraints = false
          return table
      }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.customizeBackButton()
      
    }
    
      
      override func viewDidLoad() {
          super.viewDidLoad()
   
          getData()
         
         
          navigationItem.title = ""
          view.addSubview(tableView)
          

          tableView.delegate = self
          tableView.dataSource = self
          tableView.separatorStyle = .none
          // TableView'ın constraint'lerini ayarlamak
          NSLayoutConstraint.activate([
              tableView.topAnchor.constraint(equalTo: view.topAnchor),
              tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
          ])
          
          // TableView'a özel hücre sınıfını kaydetmek
          tableView.register(JobsCell.self, forCellReuseIdentifier: "customCell")
      }
      
      // UITableViewDataSource fonksiyonları
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return JobModelList.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! JobsCell
          cell.selectionStyle = .none
       
          var model = JobModelList[indexPath.row]
          cell.nameLabel.text = "\(model.nameSurname)"
          cell.nameLabel2.text = model.detail

          let informationValues = Array(model.information.values)
          
          
          
          cell.box2.text = informationValues[0]
          cell.box3.text = informationValues[1]
          cell.box4.text = informationValues[2]
          cell.box5.text = informationValues[3]
          
          
          cell.jobPrice.isHidden = false
          
          
         
          
        
          
         
          
          return cell
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
         
          let page = Chat()
          page.receiverID = UserManager.shared.getUser().id
          
          navigationController?.pushViewController(page, animated: true)
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180  // Örnek: Hücre yüksekliği 80 piksel
        }
    
    func getData(){
          let ref = Database.database().reference()

 
              ref.child("teklifler").observe(.value, with: { snapshot in
                  self.JobModelList.removeAll()
           
              if let value = snapshot.value as? [String: Any] {
                 
                  for (_,data) in value {
                      
                      if let veri = (data as? [String: Any]) {
                          
                          
                          let model = JobModel(nameSurname: veri["nameSurname"] as! String,detail: veri["detail"] as! String, id: veri["id"] as! String, information: veri["information"] as! [String : String])
                          self.JobModelList.append(model)
                          
                                 }
                      
                      
                  }
                  
                  self.tableView.reloadData()
                  
                
                  
                     }
          }) { (error) in
              print("Error: \(error.localizedDescription)")
          }
      }
        
        
    }

