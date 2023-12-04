//
//  ResarvationItem.swift
//  Hizmet Burada
//
//  Created by turan on 25.11.2023.
//
import UIKit
class ResarvationCell: UICollectionViewCell,  UITableViewDelegate, UITableViewDataSource {
  
    

    var model: ModelQuestion? {
        didSet {
            itemTitle.text = model?.question
            model2 = model
        }
    }
    
    var model2 : ModelQuestion? = nil
    
    lazy var container : UIView = {
        let container = UIView()
        return container
    }()

    lazy var itemTitle:UILabel = {
        let nameSurname = UILabel()
        nameSurname.font = UIFont.boldSystemFont(ofSize: 24)
        nameSurname.textColor = .systemYellow
        nameSurname.textAlignment = .center
        return nameSurname
    }()
    
    lazy var item: UITableView = {
        let item = UITableView()
        item.separatorStyle = .none
        item.dataSource = self
        item.delegate = self
        item.register(ResarvationItemCell.self, forCellReuseIdentifier: "re")
      
        
        return item
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(container)
        container.addSubview(item)
        container.addSubview(itemTitle)
        desing()
    }
    
    func desing (){
        container.anchor(top: contentView.safeAreaLayoutGuide.topAnchor,
                         bottom: contentView.bottomAnchor,
                         leading: contentView.leadingAnchor,
                         trailing: contentView.trailingAnchor)
       
        itemTitle.anchor(top: container.safeAreaLayoutGuide.topAnchor,
                     bottom: nil,
                     leading: container.leadingAnchor,
                     trailing: container.trailingAnchor,
                      padding: .init(top: 30, left: 25, bottom: 0, right: 0),
                      size: .init(width: 0, height: 60))
    
        
        
        item.anchor(top: itemTitle.bottomAnchor,
                              bottom: container.bottomAnchor,
                              leading: container.leadingAnchor,
                              trailing: container.trailingAnchor,
                    padding: .init(top: 6, left: 25, bottom: 0, right: 25))
   
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model2?.answer.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "re", for: indexPath) as! ResarvationItemCell
        cell.question = model2?.question
        cell.answer = model2?.answer[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    }
