//
//  JobsCell.swift
//  Hizmet Burada
//
//  Created by turan on 6.01.2024.
//

import UIKit


class Work: UITableViewCell {
    
    lazy var separatorLine:UIView = {
        
        // Çizgi oluşturma
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray // Çizginin rengini ayarlayın
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()


    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        view.layer.shadowOpacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
    let date: UILabel = {
        let date = UILabel()
       
        date.textColor = .darkGray
        date.textAlignment = .center
        date.font = UIFont(name: "Avenir", size: 11)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    let jobName: UILabel = {
        let jobName = UILabel()
        jobName.textAlignment = .center
        jobName.font =  UIFont(name: "Avenir", size: 14)
        jobName.translatesAutoresizingMaskIntoConstraints = false
        return jobName
    }()
    
    lazy var profileImage: UIImageView = {
       let profileImage = UIImageView()
        profileImage.image = UIImage(named: "logo")
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 12
        return profileImage
    }()
    
  
   
    
    let jobStatus: UILabel = {
        let jobStatus = UILabel()
        
        jobStatus.font = UIFont(name: "Avenir", size: 11)
        jobStatus.numberOfLines = 0
        jobStatus.textAlignment = .center
        jobStatus.textColor = .darkGray
        jobStatus.text = "Talebin için teklifler toplanıyor. Teklifler gelmeye başladığında \nhemen bildireceğiz."

        return jobStatus
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Detaylara Bak", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 2
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
           return button
       }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
   
        contentView.addSubview(cardView)
        cardView.addSubview(date)
        cardView.addSubview(jobName)
        cardView.addSubview(jobStatus)
        cardView.addSubview(separatorLine)
        cardView.addSubview(profileImage)
        cardView.addSubview(nextButton)
        
       
        desing()
     
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func desing(){
        
        cardView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor,padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
    
        
        
        date.anchor(top: cardView.topAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        jobName.anchor(top: date.bottomAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        
        
        separatorLine.anchor(top: jobName.bottomAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 8, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 0.5))
        
        jobStatus.anchor(top: separatorLine.bottomAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 8, left: 12, bottom: 0, right: 12),size: .init(width: 0, height: 50))
        
        profileImage.anchor(top: jobStatus.bottomAnchor, bottom: nil, leading: nil, trailing: nil,padding: .init(top: 6, left: 0, bottom: 0, right: 0),size: .init(width: 60, height: 60))
        profileImage.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        
        nextButton.anchor(top: nil, bottom: cardView.bottomAnchor, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 0, left: 8, bottom: 8, right: 8),size: .init(width: 0, height: 36))
        
        
        
        
    }
    @objc private func nextButtonTapped() {
     
            return
        }
    
    
    
    
}
