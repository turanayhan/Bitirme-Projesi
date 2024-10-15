//
//  Opportunity.swift
//  Hizmet Burada
//
//  Created by turan on 25.12.2023.
//

import UIKit
import Firebase
import JGProgressHUD

class OpportunityPage: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    
    
    
    lazy var progresBar: JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)

        progresBar.indicatorView = JGProgressHUDIndeterminateIndicatorView() // İsteğe bağlı: Göstermek için bir gösterge ekleyin.
        return progresBar
    }()


    var JobModelList: [JobModel] = []
    var firebaseManager = FirestoreManager()
    let screenHeight = UIScreen.main.bounds.height
      
      // TableView tanımı
      let tableView: UITableView = {
          let table = UITableView()
          table.backgroundColor = .clear
          table.translatesAutoresizingMaskIntoConstraints = false
          return table
      }()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          progresBar.show(in: self.view)
          view.backgroundColor = .white
   
          getData()
         
         
          navigationItem.title = ""
          view.addSubview(tableView)
          

          tableView.delegate = self
          tableView.dataSource = self
          tableView.separatorStyle = .none
  
          NSLayoutConstraint.activate([
              tableView.topAnchor.constraint(equalTo: view.topAnchor),
              tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
          ])
          
          // TableView'a özel hücre sınıfını kaydetmek
          tableView.register(WorkOp.self, forCellReuseIdentifier: "customCell")
      }
      
      // UITableViewDataSource fonksiyonları
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return JobModelList.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! WorkOp
          cell.selectionStyle = .none
          cell.modelDetail = JobModelList[indexPath.row]
     
          return cell
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
         
          let page = JobsDetailPage()
          page.modelic = JobModelList[indexPath.row]
          
          navigationController?.pushViewController(page, animated: true)
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let calculatedHeight = screenHeight * 0.22
           let minHeight: CGFloat = 170.0 // Belirlediğiniz minimum yükseklik
           return max(calculatedHeight, minHeight)
      
        }
    
    func getData() {
        
     
        fetchJobData { jobsData in
            guard let jobsData = jobsData else {
                print("Veri alınamadı")
                return
            }

            var jobModels: [JobModel] = [] // JobModel dizisi

            // Jobs anahtarının altında döngü
            for (_, jobDetails) in jobsData {
                if let jobDetailDict = jobDetails as? [String: Any] {
                    for (_, jobInfo) in jobDetailDict {
                        if let jobInfoDict = jobInfo as? [String: Any] {
                            // JobModel oluşturma
                            let nameSurname = jobInfoDict["nameSurname"] as? String ?? ""
                            let detail = jobInfoDict["detail"] as? String ?? ""
                            let address = jobInfoDict["adress"] as? String ?? ""
                            let reservationDate = jobInfoDict["reservationDate"] as? String ?? ""
                            let announcementDate = jobInfoDict["announcementDate"] as? String ?? ""
                            
                            // Message dizisini oluşturun, gerekirse burada doldurun
                            let messages: [Message]? = nil // Gerekirse, messages'ı doldurun
                            
                            let jobModel = JobModel(
                                nameSurname: nameSurname,
                                detail: detail,
                                id: jobInfoDict["id"] as? String ?? "", // İş ID'sini buradan alıyoruz
                                information: jobInfoDict["information"] as? [String: String] ?? [:], // Bilgiler
                                message: messages,
                                adress: address,
                                announcementDate: announcementDate,
                                reservationDate: reservationDate
                            )

                            self.JobModelList.append(jobModel) // JobModel'i diziye e
                           
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                self.progresBar.dismiss(afterDelay: 2.0)
            }

        }
    }



        
    func fetchJobData(completion: @escaping ([String: Any]?) -> Void) {
        let ref = Database.database().reference().child("Jobs")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }
            completion(value)
        }
    }
        
    }

