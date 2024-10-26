//
//  TabBar.swift
//  Hizmet Burada
//
//  Created by turan on 3.11.2023.
//

import UIKit
import SideMenu
class ServiceRecipient: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = SearchPage()
        let vc2 = MyworksPage()
        let vc3 = NotificationPage()
        let vc4 = Message()
        
        vc1.title = "Hizmet Al"
        vc2.title = "İşlerim"
        vc3.title = "Bildirimler"
        vc4.title = "Hesabım"
        
        let smallSize = CGSize(width: 20, height: 20) // Küçültmek istediğiniz boyut
        
        vc1.tabBarItem.image = resizeImage(UIImage(systemName: "magnifyingglass")!, targetSize: smallSize)
        vc2.tabBarItem.image = resizeImage(UIImage(systemName: "square.and.pencil")!, targetSize: smallSize)
        vc3.tabBarItem.image = resizeImage(UIImage(systemName: "bell.fill")!, targetSize: smallSize)
        vc4.tabBarItem.image = resizeImage(UIImage(systemName: "person.crop.circle")!, targetSize: smallSize)
        
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        setViewControllers([nav1,nav2,nav3,nav4], animated: true)
        
        // Font ayarları
        let font = UIFont(name: "Avenir", size: 10) ?? UIFont.systemFont(ofSize: 12)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black // Metin rengi
        ]
        
        // Tab bar item'lar için ayarları uygula
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
        tabBar.backgroundColor = UIColor(hex: "#E3F2FD")
        tabBar.tintColor = .red
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor(hex: "#E3F2FD")
            if navigationController != nil {
      
                self.navigationController?.isNavigationBarHidden = true
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
