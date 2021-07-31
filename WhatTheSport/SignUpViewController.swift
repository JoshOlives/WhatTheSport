//
//  ViewController.swift
//  ClassDemo2
//
//  Created by bulko on 6/19/19.
//  Copyright © 2019 bulko. All rights reserved.
//

import UIKit
import Firebase
import CoreData
import FirebaseStorage

protocol Transitioner {
    func signIn (email: String, password: String)
}

class SignUpViewController: UIViewController, Transitioner {

    var emailField: UITextField!
    var usernameField: UITextField!
    var passwordField: UITextField!
    var confirmField: UITextField!
    var signUpButton: UIButton!
    var signInVC: SignInViewController!
    var constraint: NSLayoutConstraint!
    var logo: UIImageView!
    var signInLabel: UIButton!
    var user: NSManagedObject?
    
    let fieldSpacing: CGFloat = 15
    let fieldHeight: CGFloat = 45
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        //clearCoreData()
        super.viewDidLoad()
        
        var constraints: [NSLayoutConstraint] = []
        
        view.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        self.title = "Sign Up"
        
        logo = UIImageView(frame: .zero)
        logo.image = UIImage(named: "splash")
        
        uploadImage(image: logo.image!.pngData()!)
        self.view.addSubview(logo)
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(logo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor))
        constraints.append(logo.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(logo.widthAnchor.constraint(equalToConstant: view.bounds.width-50))
        constraints.append(logo.heightAnchor.constraint(equalToConstant: 125))
        
        emailField = TextField(placeholder: "Email")
        self.view.addSubview(emailField)
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(emailField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 125))
        constraints.append(emailField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(emailField.widthAnchor.constraint(equalToConstant: view.bounds.width-50))
        constraints.append(emailField.heightAnchor.constraint(equalToConstant: fieldHeight))
        
        usernameField = TextField(placeholder: "Choose username")
        self.view.addSubview(usernameField)
    
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(usernameField.centerXAnchor.constraint(equalTo: emailField.centerXAnchor))
        constraints.append(usernameField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: fieldSpacing))
        constraints.append(usernameField.widthAnchor.constraint(equalTo: emailField.widthAnchor))
        constraints.append(usernameField.heightAnchor.constraint(equalTo: emailField.heightAnchor))
        
        passwordField = SecureTextField(placeholder: "Choose password")
        self.view.addSubview(passwordField)
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(passwordField.centerXAnchor.constraint(equalTo: usernameField.centerXAnchor))
        constraints.append(passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: fieldSpacing))
        constraints.append(passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor))
        constraints.append(passwordField.heightAnchor.constraint(equalTo: emailField.heightAnchor))
        
        confirmField = SecureTextField(placeholder: "Repeat password")
        self.view.addSubview(confirmField)
        
        confirmField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(confirmField.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor))
        constraints.append(confirmField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: fieldSpacing))
        constraints.append(confirmField.widthAnchor.constraint(equalTo: emailField.widthAnchor))
        constraints.append(confirmField.heightAnchor.constraint(equalTo: emailField.heightAnchor))
        
        signUpButton = Button(title: "Sign Up")
        signUpButton.addTarget(self, action: #selector(signUpPress), for: .touchUpInside)
        self.view.addSubview(signUpButton)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(signUpButton.centerXAnchor.constraint(equalTo: confirmField.centerXAnchor))
        constraints.append(signUpButton.topAnchor.constraint(equalTo: confirmField.bottomAnchor, constant: fieldSpacing * 1.75))
        constraints.append(signUpButton.widthAnchor.constraint(equalTo: emailField.widthAnchor))
        constraints.append(signUpButton.heightAnchor.constraint(equalTo: emailField.heightAnchor))
        
//        signInLabel = UILabel(frame: .zero)
//        signInLabel.textColor = .blue
//        signInLabel.attributedText = NSAttributedString(string: "SignIn", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
//        signInLabel.textAlignment = .center
//        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.signInPress))
//        signInLabel.isUserInteractionEnabled = true
//        signInLabel.addGestureRecognizer(tap)
//        self.view.addSubview(signInLabel)
        signInLabel = LinkButton(title: "Sign In")
        signInLabel.addTarget(self, action: #selector(signInPress), for: .touchUpInside)
        self.view.addSubview(signInLabel)
        
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(signInLabel.centerXAnchor.constraint(equalTo: signUpButton.centerXAnchor))
        constraints.append(signInLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: Constants.Field.spacing))
        constraints.append(signInLabel.widthAnchor.constraint(equalTo: signUpButton.widthAnchor, multiplier: 1/5.0))
        constraints.append(signInLabel.heightAnchor.constraint(equalTo: signUpButton.heightAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func signInPress(sender: UIButton!) {
        if signInVC == nil {
            signInVC = SignInViewController()
        }
        signInVC.signUpVC = self

        if let navigator = navigationController {
            navigator.pushViewController(signInVC, animated: true)
        }
    }

    @objc func signUpPress(sender: UIButton!) {
        guard let email = emailField.text,
              let password = passwordField.text,
              let username = usernameField.text,
              email.count > 0,
              password.count > 0,
              username.count > 0
        else {
          let controller = UI.createAlert(title: "Error", msg: "fields must not be blank")
          self.present(controller, animated: true, completion: nil)
          return
        }
        
        if let confirm = confirmField.text,
        confirm == password {
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if error == nil {
                    let db = Firestore.firestore()
                    let userID = user!.user.uid
                    
                    db.collection("users").addDocument(data: ["username": username, "sports": [String](),
                                                              "teams": [String](), "postIDs": [String](),
                                                              "uid": userID ]) { (error) in
                        if error != nil {
                            let controller = UI.createAlert(title: "Error", msg: error!.localizedDescription)
                            self.present(controller, animated: true, completion: nil)
                        }
                    }
                    self.user = self.createUser(userID: userID)
                    SignUpViewController.saveContext()
                    
                    self.printUserInfo(userID: userID)

                    self.signIn (email: email, password: password)
                } else {
                    let controller = UI.createAlert(title: "Error", msg: error!.localizedDescription)
                    self.present(controller, animated: true, completion: nil)
                }
            }
        } else {
            let controller = UI.createAlert(title: "Error", msg: "Passwords do not match")
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func signIn (email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
          user, error in
          if error == nil {
            //TODO: segue to home page
            print("signed in")
          } else {
            let controller = UI.createAlert(title: "Error", msg: error!.localizedDescription)
            self.present(controller, animated: true, completion: nil)
          }
        }
    }
    
    func createUser(userID: String) -> NSManagedObject {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        
        // Set the attribute values
        user.setValue(userID, forKey: "userID")
        let settings = NSEntityDescription.insertNewObject(forEntityName: "Setting", into: context) as! Setting
        let filters = NSEntityDescription.insertNewObject(forEntityName: "Filter", into: context) as! Filter
        user.filters = filters
        user.settings = settings
        
        return user
    }
    
    func printUserInfo(userID: String) {
        let user  = retrieveUser(userID: userID) as! User
        print("core user info")
        print("\tuserID: \(user.userID)")
        print("\tsettings: \(user.settings)")
        print("\tfilters: \(user.filters)")
        
        let db = Firestore.firestore()
        let ref = db.collection("users")
        let docRef = ref.document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print("Firestore user info")
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("\tDoc data: \(dataDescription)")
            } else {
                print ("user not in Firestore")
            }
        }
    }
    
    func uploadImage(image: Data) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // Data in memory
        let data = image

        // Create a reference to the file you want to upload
        let splashref = storageRef.child("images/splash.png")

        // Upload the file to the path "images/rivers.jpg"
        splashref.putData(data, metadata: nil) { (metadata, error) in
          guard error == nil else {
            // Uh-oh, an error occurred!
            print("\n\n\n\nerror uploading picture")
            return
          }
            splashref.downloadURL { (url, error) in
                guard let url = url, error == nil else {
                  // Uh-oh, an error occurred!
                    print("\n\n\n\nerror downloading url")
                  return
                }
                
                let urlString = url.absoluteURL
                //put urlString in Firestore User
            }
        }
        print("finish with uploading")
    }
    
    func retrieveUser(userID: String) -> NSManagedObject {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"User")
        var fetchedResults:[NSManagedObject]? = nil
        
        let predicate = NSPredicate(format: "userID == '\(userID)'")
        request.predicate = predicate
        
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            // If an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        return(fetchedResults)![0]
    }
    
    static func saveContext(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        // Commit the changes
        do {
            try context.save()
        } catch {
            // If an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func clearEntity(entity: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        var fetchedResults:[NSManagedObject]
        
        do {
            try fetchedResults = context.fetch(request) as! [NSManagedObject]
            
            if fetchedResults.count > 0 {
                
                for result:AnyObject in fetchedResults {
                    context.delete(result as! NSManagedObject)
                }
            }
            try context.save()
            
        } catch {
            // If an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func clearCoreData() {
        clearEntity(entity: "User")
        clearEntity(entity: "Setting")
        clearEntity(entity: "Filter")
    }
    
}

