//
//  ResarvationItemvt.swift
//  Hizmet Burada
//
//  Created by turan on 25.11.2023.
//
import UIKit

class ResarvationItemCell: UITableViewCell {
    
    // Örneğin, her hücrede gösterilecek metin
    var labelText: String? {
        didSet {
            label.text = labelText
        }
    }
    
    lazy var container : UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(red: 1, green: 0.95, blue: 0.95, alpha: 1.0)
        container.layer.cornerRadius = 2
       
        return container
        
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    let checkBox: UIButton = {
        let button = UIButton()
         button.backgroundColor = .clear
         button.tintColor = .systemYellow
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setImage(UIImage(systemName: "circle"), for: .normal)
         button.setImage(UIImage(systemName: "checkmark.circle.fill" ), for: .selected)
         button.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
         return button
     }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(container)

        container.addSubview(checkBox)
        container.addSubview(label)
        
        
        container.anchor(top: nil,
                         bottom: nil,
                         leading: contentView.leadingAnchor,
                         trailing: nil,
                         size: .init(width: 0, height:40))
        
        container.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        checkBox.anchor(top: nil,
                        bottom: nil,
                        leading: container.leadingAnchor,
                        trailing: nil,
                        padding: .init(top: 0, left: 4, bottom: 0, right: 0),
                        size: .init(width: 30, height: 30))
        
        checkBox.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
        label.anchor(top: nil, 
                     bottom: nil,
                     leading: checkBox.trailingAnchor,
                     trailing: container.trailingAnchor,
                     padding: .init(top: 0, left: 4, bottom: 0, right: 30))
        
        label.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
    }
     
            
    
    @objc func checkBoxTapped() {
        checkBox.isSelected.toggle()
       }
}
