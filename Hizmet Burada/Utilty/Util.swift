//
//  Constrait.swift
//  Hizmet Burada
//
//  Created by turan on 2.11.2023.
//
import Foundation
import UIKit
import SideMenu


extension UIView {
    func centerAnchor(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero,
                minHeight: CGFloat? = nil,    // Min yükseklik
                maxHeight: CGFloat? = nil,    // Max yükseklik
                minWidth: CGFloat? = nil,     // Min genişlik
                maxWidth: CGFloat? = nil      // Max genişlik
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        // Sabit genişlik ve yükseklik
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
        // Min ve max yükseklik constraint'leri
        if let minHeight = minHeight {
            heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight).isActive = true
        }
        
        if let maxHeight = maxHeight {
            heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight).isActive = true
        }
        
        // Min ve max genişlik constraint'leri
        if let minWidth = minWidth {
            widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth).isActive = true
        }
        
        if let maxWidth = maxWidth {
            widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true
        }
    }
}




extension UITextField {

    func setPadding(left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) {
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
        
        self.leftView = leftPadding
        self.leftViewMode = .always
        
        self.rightView = rightPadding
        self.rightViewMode = .always
        
        let topPadding = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: top))
        let bottomPadding = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: bottom))
        
        self.addSubview(topPadding)
        self.addSubview(bottomPadding)
    }

    
}

extension UINavigationController {
    func customizeBackButton(title: String = "", tintColor: UIColor = .black) {
        let backButton = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        self.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationBar.tintColor = tintColor
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UIViewController {

    func customnNavigation() {
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
        
        // Menü ayarları
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
        func setupCustomBackButton(with title: String) {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        backButton.tintColor = .black
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .black // Başlık rengi
        titleLabel.font = UIFont(name: "Chalkduster", size: 15)
        titleLabel.textAlignment = .center
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleLabel
    }


    @objc func backButtonTapped() {
         navigationController?.popViewController(animated: true)
     }

    
}
