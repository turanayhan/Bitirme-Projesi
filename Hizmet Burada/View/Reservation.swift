//
//  Reservation.swift
//  Hizmet Burada
//
//  Created by turan on 25.11.2023.
//

import UIKit
import Firebase


class Resarvation: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {

    private var currentIndex = 0
    
    var sorular : Questions?  = nil
    
    
    lazy var collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.isPagingEnabled = false
           collectionView.isScrollEnabled = false
           collectionView.register(ResarvationCell.self, forCellWithReuseIdentifier: "CustomCell")
           return collectionView
       }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Devam", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 2
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
           return button
       }()
    
 
       override func viewDidLoad() {
           super.viewDidLoad()
           desing()
           
           var soru1 = ModelQuestion(question: "Kaç metrekare oda/ev boyanacak ?", answer: ["20","50","80","100","120","150","180","200","300","500+"])
           var soru2 = ModelQuestion(question: "Bu alan kaç Oda ?", answer: ["1 oda(4 duvar)","2 oda","3 oda","4 oda","5 oda","Daha büyük"])
           var soru3 = ModelQuestion(question: "Fiyat malzeme dahil olsun mu ?", answer: ["Malzeme dahil","Hariç - sadece işcilik"])
           var soru4 = ModelQuestion(question: "Boya badana yapılacak alan eşyalı mı olacak ?", answer: ["Boş olacak","Eşyalı olacak"])
           var soru5 = ModelQuestion(question: "Tavanlar boyanacak mı ?", answer: ["Evet","Hayır"])
           
           sorular = Questions(questions: [soru1,soru2,soru3,soru4,soru5])
          
         
       }
    
    
    func desing(){
       
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(nextButton)
        
     
        
        collectionView.anchor(top: view.topAnchor,
                              bottom: nextButton.topAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 30, left: 0, bottom: 0, right: 0))
       
        nextButton.anchor(top: nil,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 10, left: 10, bottom: 30, right: 10),
                          size: .init(width: 0, height: 40))
        
        
    }
    
    
    func deneme(){
        
        let soru1 : [String: Any] = [
            "soru": "Ev kaç metrekare ?",
            "cevap": ["120","130","200"],
           
        ]
        let soru2 : [String: Any] = [
            "soru": "Kaç oda var ?",
            "cevap": ["1","2","3"],
           
        ]
        let soru3 : [String: Any] = [
            "soru": "Ev kaç metrekare ?",
            "cevap": ["120","130","200"],
           
        ]
        
        let evtemizliği : [String: Any] = [
            "sorular": [soru1,soru2,soru3],
            "id": 0,
           
        ]
        
        let isler : [String: Any] = [
            "is adları": [evtemizliği],
           
        ]
        
        
        
        
    
        let ref = Database.database().reference()
        let yeniKullaniciRef = ref.child("isler")

        yeniKullaniciRef.setValue(isler)
        // Eklenen kullanıcının ID'sini almak
        
        
        
        
        
        
        
        
        
    }
    
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return sorular?.questions.count ?? 3 // 4 sayfa
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! ResarvationCell
           cell.model = sorular?.questions[indexPath.row]
           return cell
       }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // Hücre boyutlarını belirleyin
         return CGSize(width: collectionView.frame.width, height: collectionView.frame.height-50)
       }
    
    
    

 
    
   
    
    @objc private func nextButtonTapped() {
           // Bir sonraki öğeye geçiş yap
           currentIndex = (currentIndex + 1) % 4
           let indexPath = IndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
       }
    
    
   }



