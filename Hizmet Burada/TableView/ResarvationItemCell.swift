//
//  ResarvationItemvt.swift
//  Hizmet Burada
//
//  Created by turan on 25.11.2023.
//
import UIKit

class ResarvationItemCell: UITableViewCell {
    
    // Örneğin, her hücrede gösterilecek metin
    var question: String? {
        didSet {
            questions = question ?? "bos"
        }
    }
    var answer: String? {
        didSet {
            label.text = answer
            answers = answer ?? "bos"
        }
    }
    
    var questions = ""
    var answers = ""
    
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
        setupCell()
        
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
    
    
    func setupCell() {
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
          addGestureRecognizer(tapGesture)
      }
    
    @objc func handleTap() {
        checkBox.isSelected.toggle()
        
      

        
        let key = questions.replacingOccurrences(of: "?", with: "").replacingOccurrences(of: "+", with: "").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: "-", with: "")
        
        Jobİnformation.shared.addInfo(key: key, value:answers)
        
           }
       }

