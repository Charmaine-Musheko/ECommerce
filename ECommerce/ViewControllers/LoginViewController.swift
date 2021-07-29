//
//  LoginViewController.swift
//  ECommerce
//
//  Created by Charmaine Musheko on 19/07/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

   
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var loginError: UILabel!
    @IBOutlet weak var passwordLogin: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()

        // Do any additional setup after loading the view.
    }
    func setUpElements()  {
        Utilities.styleTextField(emailLogin)
        Utilities.styleTextField(passwordLogin)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }Elements
    */
    @IBAction func loginTapped(_ sender: Any) {
        let email = emailLogin.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordLogin.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? ViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    
}
