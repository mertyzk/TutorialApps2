//
//  addAPhotoViewController.swift
//  MyPhotoList
//
//  Created by Macbook Air on 23.05.2022.
//

import UIKit
import CoreData

class addAPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedItem : Entity?
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if selectedItem == nil {
            // new photo
            self.navigationItem.title = "Add a New Photo"
            
        } else {
            // update photo
            self.navigationItem.title = "'\((selectedItem?.titletext)!)' is editing"
            titleTextField.text = selectedItem?.titletext
            descriptionTextField.text = selectedItem?.titletext
            photoImageView.image = UIImage(data: (selectedItem?.image )!)
            saveButtonOutlet.setTitle("Update", for: UIControl.State.normal)
        }
        
        
    }
    

    @IBAction func cameraButtonClick(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        present(picker,animated: true,completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        /*photoImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true,completion: nil)*/
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func libraryButtonClick(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker,animated: true,completion: nil)
        
    }
    
    
    @IBAction func saveButtonClick(_ sender: UIButton) {
        
        
        if selectedItem == nil {
            
            let entityDescription = NSEntityDescription.entity(forEntityName: "Entity", in: persistentContainer)
            let newItem = Entity(entity: entityDescription!, insertInto: persistentContainer)
            newItem.titletext = titleTextField.text
            newItem.descriptiontext = descriptionTextField.text
            newItem.image = photoImageView.image!.jpegData(compressionQuality: 0.8) as Data?
            
        } else {
            
            selectedItem?.titletext = titleTextField.text
            selectedItem?.descriptiontext = descriptionTextField.text
            selectedItem?.image = photoImageView.image?.jpegData(compressionQuality: 0.8) as Data?
            
            
        }
        
        
        
        
        do {
            if persistentContainer.hasChanges {
                try persistentContainer.save()
            }
        } catch  {
            print(error.localizedDescription)
            return
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func dismissKeyboard(_ sender: UITextField) {
        
        self.resignFirstResponder()
        
    }
    
    
}
