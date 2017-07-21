
//
//  UserSettingViewController.swift
//  Edun_PhotoVault
//
//  Created by Kaiming Cheng on 7/20/17.
//  Copyright © 2017 Jacob Shavel. All rights reserved.
//

import UIKit
import Firebase

class UserSettingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    let image_picker = UIImagePickerController()

    @IBOutlet weak var my_imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap_gesture = UITapGestureRecognizer(target: self, action: #selector(self.image_tapped(gesture:)))
        my_imageView.isUserInteractionEnabled = true
        my_imageView.addGestureRecognizer(tap_gesture)
        image_picker.delegate = self
    }
    
    func image_tapped(gesture: UITapGestureRecognizer){
        open_action_sheet()
    }
    
    func open_action_sheet(){
        let action_sheet_vc = UIAlertController(title: "PickImage", message: "", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default, handler: camera_action)
        let gallery = UIAlertAction(title: "Gallery", style: .default, handler: gallery_action)
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        action_sheet_vc.addAction(camera)
        action_sheet_vc.addAction(gallery)
        action_sheet_vc.addAction(cancel)
        
        self.present(action_sheet_vc, animated: true, completion: nil)
        
        
    }
    
    func camera_action (action : UIAlertAction){
        
        //Open Camera
        if UIImagePickerController.isSourceTypeAvailable(.camera){
        image_picker.sourceType = .camera
        self.present(image_picker, animated: true, completion: nil)
        }
        else{
            print("Camera is not Aviable")
        }
    }
    
    func gallery_action (action : UIAlertAction){
        
        //Open Gallery
        image_picker.sourceType = .photoLibrary
        image_picker.allowsEditing = true
        self.present(image_picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // set image to imageView
        my_imageView.image = info[UIImagePickerControllerEditedImage] as! UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changePassword(_ sender: Any) {
        
        UserDefaults.standard.set(nil, forKey: "password")

    }
    


    
    
    
    
    
    
    

}
