//
//  MerchViewController.swift
//  ECommerce
//
//  Created by Charmaine Musheko on 20/07/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

 class MerchViewController: UIViewController {
    
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var loginError: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    
      override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()

        // Do any additional setup after loading the view.
    }

    func setUpElements(){
        loginError.alpha = 0
        Utilities.styleTextField(FirstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailAddressField)
        Utilities.styleTextField(passwordField)
        Utilities.styleFilledButton(createAccountButton)
        
    }

    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailAddressField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    


    
    func showError(_ message:String) {
        
        loginError.text = message
        loginError.alpha = 1
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
            let firstName = FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailAddressField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
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
                    self.present( UIStoryboard(name: "Merchant", bundle: nil).instantiateViewController(withIdentifier: "Merchant") as UIViewController, animated: true, completion: nil)
                }
                
            }
            
            
        }
            }
}

