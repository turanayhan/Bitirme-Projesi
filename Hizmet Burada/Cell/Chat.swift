//
//  ChatCell.swift
//  Hizmet Burada
//
//  Created by turan on 13.01.2024.
//

import Foundation
import UIKit

// Özel hücre sınıfı
class Chat: UITableViewCell {
    static let identifier = "ChatCell"
    
    var modelic : MessageModel? {
        didSet {
            
            messageLabelSend.text = modelic?.text
            messageLabelRecaiver.text = modelic?.text
            
        }
    }
    
    let messageLabelRecaiver: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Bu ilk mesajımızdır"
        label.font = UIFont.systemFont(ofSize: 14) // Yazı boyutunu ayarla
        label.textColor = UIColor.black
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.3
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 2
        label.clipsToBounds = true
        label.isHidden = true
        label.textAlignment = .center
        
        let minWidthConstraint = label.widthAnchor.constraint(greaterThanOrEqualToConstant: 80) // Minimum genişlik değeri
          minWidthConstraint.isActive = true
        

        return label
    }()

    let messageLabelSend: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Ne demek istediniz?"
        label.font = UIFont.systemFont(ofSize: 14) // Yazı boyutunu ayarla
        label.backgroundColor = UIColor.systemYellow
        label.textColor = UIColor.black
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 2
        label.clipsToBounds = true
        label.isHidden = true
        label.textAlignment = .center
        
        let minWidthConstraint = label.widthAnchor.constraint(greaterThanOrEqualToConstant: 80) // Minimum genişlik değeri
          minWidthConstraint.isActive = true
        
        return label
    }()

    lazy var container : UIView = {
        let container = UIView()
        return container
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(container)
        container.addSubview(messageLabelRecaiver)
        container.addSubview(messageLabelSend)
        desing()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func desing(){
        
        container.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor,padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        
        messageLabelRecaiver.anchor(top: container.topAnchor, bottom: container.bottomAnchor, leading: container.leadingAnchor, trailing: nil,padding: .init(top: 6, left: 0, bottom: 0, right: 0))
        
        messageLabelSend.anchor(top: container.topAnchor, bottom: container.bottomAnchor, leading: nil, trailing: container.trailingAnchor,padding: .init(top: 6, left: 0, bottom: 0, right: 0))
        
        
    }
   
}
