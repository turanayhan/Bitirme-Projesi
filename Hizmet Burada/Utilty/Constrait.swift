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



