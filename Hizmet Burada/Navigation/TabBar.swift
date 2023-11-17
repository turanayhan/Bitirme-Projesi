//
//  TabBar.swift
//  Hizmet Burada
//
//  Created by turan on 3.11.2023.
//

import UIKit

class TabBar: UITabBarController {
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let vc1 = Search()
        let vc2 = Myworks()
        let vc3 = Notification()
        let vc4 = Profile()
        
        
     
        
        vc1.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc2.tabBarItem.image = UIImage(systemName: "rectangle.and.pencil.and.ellipsis")
        vc3.tabBarItem.image = UIImage(systemName: "bell.fill")
        vc4.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        
        vc1.title = "Hizmet Al"
        vc2.title = "İşlerim"
        vc3.title = "Bildirimler"
        vc4.title = "Hesabım"
        
       
        
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
