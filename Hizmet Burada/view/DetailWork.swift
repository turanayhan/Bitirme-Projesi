//
//  DetailWork.swift
//  Hizmet Burada
//
//  Created by turan on 13.11.2023.
//

import UIKit
import JGProgressHUD



class DetailWork: UIViewController , UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
   
    
    let firestoreManager = FirestoreManager()
    var modelDetail : WorkModel? {
            didSet {
                
                infoText.text = modelDetail?.workName
               
                let imagePath = "hizmetImage/\(modelDetail?.imageUrl ?? "repair").jpg"
                firestoreManager.downloadImage(from: imagePath) { image in
                    if let image = image {
                        self.workImage.image = image
                        self.progresBar.dismiss()
                        
                    } else {
                        // Görsel indirme başarısız oldu
                    }
                }
                
                
                
                
            }
        }
    
    lazy var progresBar:JGProgressHUD = {
        
        let progresBar = JGProgressHUD(style: .light)
     
        return  progresBar
        
    }()
    
    
    lazy var stackView:UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
        
    }()
    
    
    lazy var workImage: UIImageView = {
       let workImage = UIImageView()
        workImage.contentMode = .scaleAspectFill
        workImage.clipsToBounds = true
        return workImage
    }()
    
    lazy var infoText:UITextView = {
        
        let infoText = UITextView()
        infoText.textColor = .white
        infoText.backgroundColor = UIColor.clear
        infoText.font = UIFont.boldSystemFont(ofSize: 24)
        infoText.isEditable = false
        return infoText
    }()
    
    
    
    lazy var text : UITextView = {
        
         let text = UITextView()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 5, width: 20, height: 20))
        imageView.image = UIImage(systemName:  "person.fill")
        imageView.tintColor = .systemYellow
        text.textColor = .black
        text.font = UIFont(name: "Thonburi", size: 12)
        text.isScrollEnabled = false
        text.isEditable = false
        text.text = "       1.300 Temizlikçi hazır"
        text.textAlignment = .justified
        text.addSubview(imageView)
        
        return text
        
        
    }()
    
    lazy var text2 : UITextView = {
        
         let text2 = UITextView()
        let icon2 = UIImageView(frame: CGRect(x: 0, y: 5, width: 20, height: 20))
        icon2.image = UIImage(systemName:  "star.fill")
        icon2.tintColor = .systemYellow
        text2.textColor = .black
        text2.isScrollEnabled = false
        text2.font = UIFont(name: "Thonburi", size: 12)
        text2.isEditable = false
        text2.text = "       4.5 ortalama puan (300 Onaylı yorum)"
        text2.textAlignment = .justified
        text2.addSubview(icon2)
        
        return text2
        
        
    }()
    
    lazy var text3 : UITextView = {
        
         let text3 = UITextView()
        let icon3 = UIImageView(frame: CGRect(x: 0, y:5, width: 20, height: 20))
        icon3.image = UIImage(systemName:  "checkmark")
        icon3.tintColor = .systemYellow
        text3.textColor = .black
        text3.isScrollEnabled = false
        text3.font = UIFont(name: "Thonburi", size: 12)
        text3.isEditable = false
        text3.text = "       Yılda 3.100 kişi Hizmet Burada 'ya güveniyor"
        text3.textAlignment = .justified
        text3.addSubview(icon3)
        
        return text3
        
        
    }()
    
    lazy var text4 : UITextView = {
        
         let text4 = UITextView()
        let icon4 = UIImageView(frame: CGRect(x: 0, y: 5, width: 20, height: 20))
        icon4.image = UIImage(systemName:  "checkerboard.shield")
        icon4.tintColor = .systemYellow
        text4.textColor = .black
        text4.font = UIFont(name: "Thonburi", size: 12)
        text4.isEditable = false
        text4.text = "       Hizmet Burada Garantisi kapsamındadır"
        text4.textAlignment = .justified
        text4.addSubview(icon4)
        
        return text4
        
        
    }()
    
    lazy var commentText : UITextView = {
        
         let commentText = UITextView()
        commentText.textColor = .black
        commentText.font = UIFont(name: "Thonburi", size: 15)
        commentText.isEditable = false
        commentText.text = "Müşteri Yorumları"
        commentText.textAlignment = .justified
        return commentText
        
        
    }()
    
    lazy var collectionView:UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.showsHorizontalScrollIndicator = false
            cv.register(Comment.self, forCellWithReuseIdentifier: "cell")
            return cv
        }()
    
    lazy var createButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rezervasyon Yap", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        progresBar.show(in: self.view)
        view.backgroundColor = .white
        view.addSubview(workImage)
        workImage.addSubview(infoText)
        view.addSubview(stackView)
        view.addSubview(commentText)
        stackView.addArrangedSubview(text)
        stackView.addArrangedSubview(text2)
        stackView.addArrangedSubview(text3)
        stackView.addArrangedSubview(text4)
        view.addSubview(collectionView)
        view.addSubview(createButton)
        
        
      
        
        desing()

    }
    
    func desing (){
        navigationController?.navigationBar.tintColor = .black
        
        workImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: view.frame.height/4))
        
        infoText.anchor(top: nil, bottom: workImage.bottomAnchor, leading: workImage.leadingAnchor, trailing: workImage.trailingAnchor,padding: .init(top: 0, left: 10, bottom:10, right: 0),size: .init(width: 0, height: 35))
        stackView.anchor(top: workImage.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 10, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: view.frame.height/7))
        
        commentText.anchor(top: stackView.bottomAnchor, bottom: nil, leading: stackView.leadingAnchor, trailing: stackView.trailingAnchor,padding: .init(top: 6, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 30))
        
        
        collectionView.anchor(top:commentText.bottomAnchor,
                              bottom: nil,
                              leading: stackView.leadingAnchor,
                              trailing: stackView.trailingAnchor,
                              padding: .init(top: 0, left: 10, bottom: 0, right: 10),
                              size: .init(width: 0, height: view.frame.height/4.5))
        
        
        createButton.anchor(top: collectionView.bottomAnchor,
                            bottom: nil,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            padding: .init(top: 2, left: 25, bottom: 8, right: 25),
                            size: .init(width: 0, height: 50))
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.width/2.5)
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
           print("Tıklanan öğe indeksi: \(indexPath.item)")
        
        
       
       }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Comment
            cell.modelic = nil
            return cell
        }
    
    
    @objc func buttonClicked() {
            print("Button Clicked!")
            // Buraya tıklandığında gerçekleşmesini istediğiniz eylemi ekleyebilirsiniz.
        }

}
