//
//  Myworks.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//

import UIKit
import FirebaseDatabaseInternal
import SideMenu
import JGProgressHUD

class MyworksPage: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    var JobModelList: [JobModel] = []
    var firebaseManager = FirestoreManager()
    let screenHeight = UIScreen.main.bounds.height
    
    lazy var separatorLine:UIView = {
        
        // Çizgi oluşturma
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray // Çizginin rengini ayarlayın
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    lazy var header:UITextView = {
        let header = UITextView()
        header.text = "İşlerim"
        header.font = UIFont(name: "Avenier", size: 12)
        header.textColor = .black
        header.backgroundColor = .clear
        header.textAlignment = .center
        
        return header
    }()
    
    lazy var descripiton:UITextView = {
        let descripiton = UITextView()
        descripiton.text = "Hizmet talebi oluşturduktan sonra gelişmeleri bu ekrandan takip\nedebilirsin."
        descripiton.textColor = .darkGray
        descripiton.font = UIFont(name: "Avenir", size: 10)
        descripiton.backgroundColor = .clear
        descripiton.textAlignment = .center
        
        return descripiton
    }()
    
    lazy var progresBar: JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        return progresBar
    }()
    
    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "rb_2040")
        logo.contentMode = .scaleAspectFit
        logo.backgroundColor = .clear
        return logo
    }()
    
    lazy var container : UIView = {
        
        let container = UIView()
        container.backgroundColor = .clear
        return container
    }()
    
    
    let tableView: UITableView = {
        let table = UITableView()
        table.tag = 1
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var worksTableView: UITableView = {
        let worksTableView = UITableView()
        worksTableView.separatorStyle = .none
        worksTableView.backgroundColor = .clear
        worksTableView.tag = 2
        return worksTableView
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        progresBar.show(in: self.view)
        menu()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
   

        navigationItem.title = ""
        view.addSubview(tableView)
        view.backgroundColor = UIColor(hex: "#F1FAFE")

        worksTableView.dataSource = self
        worksTableView.delegate = self
        worksTableView.register(jobVr.self, forCellReuseIdentifier: "re")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        desin()
        tableView.register(Work.self, forCellReuseIdentifier: "customCell")
        
        
        
        
       
        
        
        
    }
    
    func desin(){
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height

        view.addSubview(container)
        container.addSubview(logo)
        container.addSubview(header)
        container.addSubview(descripiton)
       
        
        
        tableView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        container.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: 0))
        
        
        logo.anchor(top: nil, bottom: header.topAnchor, leading: nil, trailing: nil,size: .init(width: width*0.7, height: width*0.7))
        logo.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true

        
        
        header.anchor(top: nil, bottom: descripiton.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor,size: .init(width: 0, height: 30))
       
        
        descripiton.anchor(top: nil, bottom: container.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 24, right: 0),size: .init(width: 0, height: 50))
        
    }
    
    
    
    // UITableViewDataSource fonksiyonları
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JobModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! Work
        cell.selectionStyle = .none
        var model = JobModelList[indexPath.row]
        cell.date.text = model.announcementDate
        cell.jobName.text = model.detail
        let informationValues = Array(model.information.values)
        
        
        
        if model.information.isEmpty {
            cell.profileImage.isHidden = false // Boşsa hücre yüksekliği 150 px olsun
            cell.jobStatus.text = "Talebin için teklifler gelmeye başladı."
            cell.nextButton.setTitle("İletişime Geç", for: .normal)
        } else {
            cell.profileImage.isHidden = true
            
            // Doluysa hücre yüksekliği 200 px olsun
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let page = ChatPage()
        page.receiverID = UserManager.shared.getUser().id
        
        navigationController?.pushViewController(page, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let jobModel = JobModelList[indexPath.row]
        
        
        if jobModel.information.isEmpty {
            return screenHeight*0.3  // Boşsa hücre yüksekliği 150 px olsun
        } else {
            return screenHeight*0.22
            // Doluysa hücre yüksekliği 200 px olsun
        }
    }
    
    func getData() {
        guard let userId = UserManager.shared.getUser().id else { return }
        
        let ref = Database.database().reference().child("Jobs").child(userId) // Kullanıcı ID'sine göre alt düğüme erişim
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let jobsData = snapshot.value as? [String: [String: Any]] else {
                print("Veri alınamadı veya beklenmeyen formatta.")
                self.progresBar.dismiss()
                return
            }
            
            // Jobs içerisindeki her bir veriyi işleyelim
            for (_, jobDetails) in jobsData {
                let address = jobDetails["adress"] as? String ?? "Adres yok"
                let detail = jobDetails["detail"] as? String ?? "Detay yok"
                let reservationDate = jobDetails["reservationDate"] as? String ?? "Rezervasyon tarihi yok"
                let nameSurname = jobDetails["nameSurname"] as? String ?? "İsim yok"
                let id = jobDetails["id"] as? String ?? "ID yok"
                let information = jobDetails["information"] as? [String: String] ?? [:]
                let announcementDate = jobDetails["announcementDate"] as? String ?? "tarih yok"
                
                // JobModel nesnesini oluştur
                let job = JobModel(nameSurname: nameSurname, detail: detail, id: id, information: information, adress: address,announcementDate: announcementDate, reservationDate: reservationDate)
                
                // JobModelList'e ekle
                self.JobModelList.append(job)
            }
            
            // TableView'ı güncelleyin
            self.tableView.reloadData()
            print("Toplam \(self.JobModelList.count) iş modeli yüklendi.")
            self.progresBar.dismiss()
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
