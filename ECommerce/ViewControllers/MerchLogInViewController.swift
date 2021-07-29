//
//  MerchLogInViewController.swift
//  ECommerce
//
//  Created by Charmaine Musheko on 20/07/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MerchLogInViewController: UIViewController {
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    @IBOutlet weak var loginButton: UIButton!
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
                self.present( UIStoryboard(name: "Merchant", bundle: nil).instantiateViewController(withIdentifier: "Merchant") as UIViewController, animated: true, completion: nil)
            }
        }
    }
    
    
}
