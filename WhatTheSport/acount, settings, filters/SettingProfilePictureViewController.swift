//
//  SettingViewController.swift
//  The final
//
//  Created by John Wang on 8/1/21.
//

import UIKit
import AVFoundation

class SettingProfilePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    var titleLabel2: UILabel!
//    var nameLabel2: UILabel!
//    var textField2: UITextField!
    var button: UIButton!
    
    var photo: UIImage!
    
    var userPhoto : UIImageView = {
        let photo = UIImageView()
       // photo.image = self.photo
        return photo
    }()
       
    
    let picker = UIImagePickerController()
    
    var delegate: AccountPageViewController!
    
 //   var delegate: AccountPageViewController!
   
    //var vc2NewName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
      //  let tabBarVC = UITabBarController()
        self.navigationController?.isToolbarHidden = false

        let libraryButton : UIBarButtonItem = {
            let barButton = UIBarButtonItem()
            barButton.title = "Library"
            barButton.target = self
            barButton.action =  #selector (libraryButtonSelected )

            return barButton
        }()
        
        let cameraButtton : UIBarButtonItem = {
            let barButton = UIBarButtonItem()
            barButton.title = "Camera"
            barButton.target = self
            barButton.action =  #selector (cameraButtonSelected)

            return barButton
        }()

        var items = [UIBarButtonItem]()

        items.append(libraryButton)
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        items.append(cameraButtton)
        toolbarItems = items
    
        view.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        
        var constraints: [NSLayoutConstraint] = []
        
        userPhoto = UIImageView(frame: .zero)
        userPhoto.image = photo
        userPhoto.contentMode = .scaleToFill
        userPhoto.layer.masksToBounds = true
        userPhoto.backgroundColor = .white
        self.view.addSubview(userPhoto)

        userPhoto.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(userPhoto.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80))
        constraints.append(userPhoto.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(userPhoto.widthAnchor.constraint(equalToConstant: view.bounds.width-50))
        constraints.append(userPhoto.heightAnchor.constraint(equalToConstant: 400))
        
        
        
        button = UIButton(type: .roundedRect)
        button.frame = CGRect(x:20, y:300, width:50, height:30)
        button.setTitle("Save", for: .normal)
        button.center = CGPoint(x: view.bounds.midX, y: 630)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        inTransition = false
    }
    
    
    @objc func libraryButtonSelected (_ sender: Any) {
        
        picker.allowsEditing = false
        
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let chosenImage = info[.originalImage] as! UIImage
        
        userPhoto.contentMode = .scaleToFill
        userPhoto.image = chosenImage
        photo = chosenImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        print("User cancelled")

    }
    
    @objc func buttonPressed(_ sender: Any) {
        if inTransition {
            return
        } else {
            inTransition = true
        }
        
        let nextVC = delegate!
        nextVC.updatePicture(newPhoto: photo)
        IO.uploadImage(image: photo, format: "jpeg", update: true)
        
        if let navigator = navigationController {
            navigator.popViewController(animated: true)
        }
    }
    
    @objc func cameraButtonSelected(_ sender: Any) {
        
        if UIImagePickerController.availableCaptureModes(for: .front) != nil {

            // there is a rear camera!
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) {
                    accessGranted in
                    guard accessGranted == true else { return }
                }
            case .authorized:
                break
            default:
                print("Access denied")
                return
            }

            // We are authorized to use the camera

            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo

            present(picker, animated: true, completion: nil)

        }
        else {
            
                // if no camera is available, pop up an alert
                
                let alertVC = UIAlertController(
                    title: "No camera",
                    message: "Sorry, this device has no camera",
                    preferredStyle: .alert
                )
                
                let okAction = UIAlertAction(
                    title: "OK",
                    style:.default,
                    handler: nil
                )
                alertVC.addAction(okAction)
                present(alertVC, animated:true, completion:nil)
            }
    }

}
