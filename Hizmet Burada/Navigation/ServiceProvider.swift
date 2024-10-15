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

class ServiceProvider: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = OpportunityPage()
        let vc2 = OfferPage()
       
        let vc4 = ProfileService()
        let smallSize = CGSize(width: 20, height: 20) // Küçültmek istediğiniz boyut
        
        
        vc1.tabBarItem.image = resizeImage(UIImage(systemName: "doc.text")!, targetSize: smallSize)
        vc2.tabBarItem.image = resizeImage(UIImage(systemName: "briefcase")!, targetSize: smallSize)
       
        vc4.tabBarItem.image = resizeImage(UIImage(systemName: "person.crop.circle")!, targetSize: smallSize)
        vc1.title = "Fırsat"
        vc2.title = "Teklif"
    
        vc4.title = "Profilim"
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)

        let nav4 = UINavigationController(rootViewController: vc4)
        tabBar.tintColor = .label
        tabBar.backgroundColor = .white
        setViewControllers([nav1,nav2,nav4], animated: true)
        
        
        
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
            if navigationController != nil {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
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
