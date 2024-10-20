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
import SideMenu

class ServiceProvider: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = OpportunityPage()
        let vc2 = OfferPage()
        let vc3 = MeetingPage()
        let vc4 = ProfileService()
        
        let smallSize = CGSize(width: 20, height: 20) // Küçültmek istediğiniz boyut
        
        
        vc1.tabBarItem.image = resizeImage(UIImage(systemName: "flame.fill")!, targetSize: smallSize)
        vc2.tabBarItem.image = resizeImage(UIImage(systemName: "bag.fill")!, targetSize: smallSize)
        vc3.tabBarItem.image = resizeImage(UIImage(systemName: "calendar")!, targetSize: smallSize)
        vc4.tabBarItem.image = resizeImage(UIImage(systemName: "bell.fill")!, targetSize: smallSize)
        
        vc1.title = "Fırsatlar"
        vc2.title = "Teklifler"
        vc3.title = "Randevu"
        vc4.title = "Bildirimler"
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
    
        setViewControllers([nav1,nav2,nav3,nav4], animated: true)
        
        
        
        let font = UIFont(name: "Avenir", size: 10) ?? UIFont.systemFont(ofSize: 12)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black // Metin rengi
        ]
        
        // Tab bar item'lar için ayarları uygula
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)
        
        
        
        
        
        
        
        let menuButton = UIBarButtonItem(
            image: UIImage(systemName: "line.horizontal.3"), // Menü ikonu
            style: .plain,
            target: self,
            action: #selector(openMenu)
        )
        menuButton.tintColor = .black // Simge rengi (isteğe bağlı)

        navigationItem.leftBarButtonItem = menuButton
        
        // Menü ayarları
        let menu = SideMenuNavigationController(rootViewController: Menu())
        menu.leftSide = true // Sol taraftan açılacak
        SideMenuManager.default.leftMenuNavigationController = menu
        
        // Kaydırarak menü açmayı etkinleştir
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        
        
        
        
        
    }
    
    
    @objc func openMenu() {
        if let menu = SideMenuManager.default.leftMenuNavigationController {
    
            present(menu, animated: true, completion: nil)
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
        tabBar.backgroundColor = UIColor(hex: "#E3F2FD")
        tabBar.tintColor = .red
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor(hex: "#E3F2FD")
            if navigationController != nil {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationController?.isNavigationBarHidden = false
            }
        }
    
    
    // Resmi yeniden boyutlandırma fonksiyonu
    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
