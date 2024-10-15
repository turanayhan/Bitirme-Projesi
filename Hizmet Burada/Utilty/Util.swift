//
//  Constrait.swift
//  Hizmet Burada
//
//  Created by turan on 2.11.2023.
//
import Foundation
import UIKit


extension UIView{
    func centerAnchor(size : CGSize = .zero) {
        
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
    
    func anchor(top : NSLayoutYAxisAnchor?,
                bottom:NSLayoutYAxisAnchor?,
                leading:NSLayoutXAxisAnchor?,
                trailing:NSLayoutXAxisAnchor?,
                padding:UIEdgeInsets = .zero,
                size:CGSize = .zero
                
    ){
        translatesAutoresizingMaskIntoConstraints=false
        
        if let top = top{
            
            self.topAnchor.constraint(equalTo: top, constant:padding.top).isActive = true
            
        }
        
        if let bottom = bottom{
            
            self.bottomAnchor.constraint(equalTo: bottom, constant:-padding.bottom).isActive = true
            
        }
        
        if let leading = leading{
            
            self.leadingAnchor.constraint(equalTo: leading, constant:padding.left).isActive = true
            
        }
        
        if let trailing = trailing{
            
            self.trailingAnchor.constraint(equalTo: trailing, constant:-padding.right).isActive = true
            
        }
        
        if size.width != 0{
            
            widthAnchor.constraint(equalToConstant: size.width).isActive=true
            
        }
        if size.height != 0{
            
            heightAnchor.constraint(equalToConstant: size.height).isActive=true
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
