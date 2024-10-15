import UIKit
import Firebase
import FirebaseStorage

class Deneme: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imageView = UIImageView()
    let selectImageButton = UIButton()
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        // imageView ayarlamaları
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        // Buton ayarlamaları
        selectImageButton.setTitle("Görsel Seç", for: .normal)
        selectImageButton.setTitleColor(.blue, for: .normal)
        selectImageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        selectImageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectImageButton)

        // Otomatik düzen ayarları
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            selectImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectImageButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
    }

    @objc func selectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    // UIImagePickerControllerDelegate metodları
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            self.selectedImage = selectedImage
            imageView.image = selectedImage
            
            // Görseli Firebase'e yükle
            uploadImageToFirebase(image: selectedImage)
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImageToFirebase(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        // Resmin yükleneceği yolu belirleyin
        let imageRef = storageRef.child("images/\(UUID().uuidString).jpg")
        
        // Resmi yükleme
        let uploadTask = imageRef.putData(imageData, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                // Hata durumunda burası çalışır
                print("Hata: \(error?.localizedDescription ?? "Bilinmeyen hata")")
                return
            }
            // Yükleme tamamlandığında burası çalışır
            print("Yükleme tamamlandı: \(metadata.path!)")
        }
    }
}
