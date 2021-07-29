//
//  AuthenticViewController.swift
//  ECommerce
//
//  Created by Charmaine Musheko on 19/07/2021.
//

import UIKit

class AuthenticViewController: UIViewController {


    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements(){
        Utilities.styleHollowButton(loginButton)
        Utilities.styleFilledButton(signUpButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
