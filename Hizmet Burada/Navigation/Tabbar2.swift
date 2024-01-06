//
//  Tabbar2.swift
//  Hizmet Burada
//
//  Created by turan on 25.12.2023.
//
//
//  TabBar.swift
//  Hizmet Burada
//
//  Created by turan on 3.11.2023.
//

import UIKit

class TabBar2: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = Opportunity()
        let vc2 = Offer()
        let vc3 = Meeting()
        let vc4 = ExtraProfile()
        
        
        vc1.tabBarItem.image = UIImage(systemName: "doc.text")
        vc2.tabBarItem.image = UIImage(systemName: "briefcase")
        vc3.tabBarItem.image = UIImage(systemName: "calendar")
        vc4.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        vc1.title = "Fırsat"
        vc2.title = "Teklif"
        vc3.title = "Randevu"
        vc4.title = "Profilim"
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        tabBar.tintColor = .label
        tabBar.backgroundColor = .white
        setViewControllers([nav1,nav2,nav3,nav4], animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if navigationController != nil {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationController?.isNavigationBarHidden = true
            }
        }
}
