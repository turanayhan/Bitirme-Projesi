//
//  JobsCell.swift
//  Hizmet Burada
//
//  Created by turan on 6.01.2024.
//

import UIKit

class JobsCell: UITableViewCell {

    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
      
        return label
    }()
    
  
    let jobDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
 
    let box1: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        box.translatesAutoresizingMaskIntoConstraints = false
        box.layer.borderWidth = 0.5 // Set the border width as needed
        box.layer.borderColor = UIColor.lightGray.cgColor // Set the border color as needed
        let imageView = UIImageView(image: UIImage(systemName: "phone.badge.waveform.fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        box.addSubview(imageView)
        
        
        NSLayoutConstraint.activate([
              imageView.topAnchor.constraint(equalTo: box.topAnchor),
              imageView.leadingAnchor.constraint(equalTo: box.leadingAnchor),
              imageView.trailingAnchor.constraint(equalTo: box.trailingAnchor),
              imageView.bottomAnchor.constraint(equalTo: box.bottomAnchor)
          ])
        
        
          return box
    }()
    
    let box2: UILabel = {
        let box = UILabel()
        box.textAlignment = .center
        box.font = UIFont(name: "verdana", size: 12)
        box.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        box.translatesAutoresizingMaskIntoConstraints = false
        box.layer.borderWidth =  0.5 // Set the border width as needed
        box.layer.borderColor = UIColor.lightGray.cgColor // Set the border color as needed
        return box
    }()
    
    let box3: UILabel = {
        let box = UILabel()
        box.textAlignment = .center
        box.font = UIFont(name: "verdana", size: 12)
        box.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        box.translatesAutoresizingMaskIntoConstraints = false
        box.layer.borderWidth =  0.5 // Set the border width as needed
        box.layer.borderColor = UIColor.lightGray.cgColor // Set the border color as needed
        return box
    }()
    
    let box4: UILabel = {
        let box = UILabel()
        box.textAlignment = .center
        box.font = UIFont(name: "verdana", size: 12)
        box.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        box.translatesAutoresizingMaskIntoConstraints = false
        box.layer.borderWidth =  0.5 // Set the border width as needed
        box.layer.borderColor = UIColor.lightGray.cgColor // Set the border color as needed
        return box
    }()
    
    let box5: UILabel = {
        let box = UILabel()
        box.textAlignment = .center
        box.font = UIFont(name: "verdana", size: 12)
        box.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        box.translatesAutoresizingMaskIntoConstraints = false
        box.layer.borderWidth =  0.5 // Set the border width as needed
        box.layer.borderColor = UIColor.lightGray.cgColor // Set the border color as needed
        return box
    }()
    
    let jobPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Teklif ettiğin fiyat = 200"
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
   
        contentView.addSubview(cardView)
        cardView.addSubview(nameLabel)
        cardView.addSubview(nameLabel2)
        cardView.addSubview(jobDescriptionLabel)
        cardView.addSubview(box1)
        cardView.addSubview(box2)
        cardView.addSubview(box3)
        cardView.addSubview(box4)
        cardView.addSubview(box5)
        cardView.addSubview(jobPrice)
        jobPrice.isHidden = true
        
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            nameLabel2.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameLabel2.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            jobDescriptionLabel.topAnchor.constraint(equalTo: nameLabel2.bottomAnchor, constant: 4),
            jobDescriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            box1.topAnchor.constraint(equalTo: jobDescriptionLabel.bottomAnchor, constant: 8),
            box1.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            box1.widthAnchor.constraint(equalToConstant: 16),
            box1.heightAnchor.constraint(equalToConstant: 16),
            box2.topAnchor.constraint(equalTo: jobDescriptionLabel.bottomAnchor, constant: 8),
            box2.leadingAnchor.constraint(equalTo: box1.trailingAnchor, constant: 8),
            box2.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 1/4),
            box2.heightAnchor.constraint(equalToConstant: 16),
            box3.topAnchor.constraint(equalTo: jobDescriptionLabel.bottomAnchor, constant: 8),
            box3.leadingAnchor.constraint(equalTo: box2.trailingAnchor, constant: 8),
            box3.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 1/4),
            box3.heightAnchor.constraint(equalToConstant: 16),
            box5.topAnchor.constraint(equalTo: jobDescriptionLabel.bottomAnchor, constant: 8),
            box5.leadingAnchor.constraint(equalTo: box3.trailingAnchor, constant: 8),
            box5.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 1/4),
            box5.heightAnchor.constraint(equalToConstant: 16),
            box4.topAnchor.constraint(equalTo: box3.bottomAnchor, constant: 8),
            box4.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            box4.trailingAnchor.constraint(equalTo: box2.trailingAnchor),
            box4.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 1/3),
            box4.heightAnchor.constraint(equalToConstant: 16),
            
            
            jobPrice.topAnchor.constraint(equalTo: box4.bottomAnchor, constant: 12),
            jobPrice.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            jobPrice.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            jobPrice.widthAnchor.constraint(equalTo: cardView.widthAnchor),
            jobPrice.heightAnchor.constraint(equalToConstant: 16)
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
