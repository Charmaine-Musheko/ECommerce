//
//  SignUpViewController.swift
//  ECommerce
//
//  Created by Charmaine Musheko on 19/07/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNametextfield: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    
    @IBOutlet weak var paswordTextField:
        UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var errorlabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()

        // Do any additional setup after loading the view.
    }

    func setUpElements(){
        errorlabel.alpha = 0
        Utilities.styleTextField(firstNametextfield)
        Utilities.styleTextField(lastnameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(paswordTextField)
        Utilities.styleTextField(firstNametextfield)
        Utilities.styleFilledButton(signUpButton)
        
    }

    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNametextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            paswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = paswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    


    
    func showError(_ message:String) {
        
        errorlabel.text = message
        errorlabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? ViewController
        
        view.window?.rootViewController = homeViewController
     
        
    }
    @IBAction func signUpTapped(_ sender: Any) {
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = firstNametextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = paswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToHome()
                }
                
            }
            
            
        }
            }
}
