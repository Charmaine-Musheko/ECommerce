//
//  ViewController.swift
//  FoodTracker
//
//  Created by Charmaine Musheko on 26/03/2021.
//

import UIKit
import os.log
import Firebase
import FirebaseStorage

class MerchantViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//MARK: Properties
    
    private let storage = Storage.storage().reference()
//
    @IBOutlet weak var nameTextField: UITextField! //IBOutlet attribute tells XCode that you can connect to the nameTextField property from Interface Builder
    @IBOutlet weak var photoImageView: UIImageView!//exclamation point indicates that this is a implicitly unwrapped optional variable (will always have a value after its set)
    @IBOutlet weak var ratingControl: RatingControl!
    /*This value is either passed by 'MealTableViewController' in 'prepare(for:sender:)'
     or constructed as part of adding a new meal*/
    var meal: Merchant?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    // understand the view controller lifecycle
    //viewDidLoad use this method to perform any additional setup required by the time this method is called.
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
       //Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
        
        //Set up views if editing an exisiting meal
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        // Enable the Save button only if the text field has a valid Meal name
        updateSaveButtonState()
        
    }
//MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
            //Disable the save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        updateSaveButtonState()
        navigationItem.title = textField.text
       
    }
    
    //MARK: UIImagePickerControllerDelegate
    // helps the touch mechanism pick pics from the camera
    func  imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        //Dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
        guard let imageData = selectedImage.pngData() else {
            return  }
        
            storage.child("image/file.png").putData(imageData, metadata: nil, completion: {_, error in
            guard error == nil else {
                print("failed to upload")
                return
            }
                self.storage.child("image/file.png").downloadURL(completion: {url, error in
                    guard let url = url, error == nil else {
                        return
                    }
                    let urlString = url.absoluteString
                    print("Download URL:\(urlString)")
                    UserDefaults.standard.set(urlString, forKey: "url")
                    
                })
            
            })
}
        
    
 //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) { //helps the cancel button cancel stuff
        //Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed intwo different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
        
        dismiss(animated: true, completion: nil)
    }
    //This method lets you configure a view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        super.prepare(for: segue, sender: sender)
        //Configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //Set the meal to be passed to MealTableViewController after the unwind segue
        
        meal = Merchant(name: name, photo: photo, rating: rating)
    }
    
//MARK: Actions
    //Action is a piece of code that's linked to an event that can occur in your app
    @IBAction func uploadButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
            
            //Only allow photos to be picked, not taken.
            imagePickerController.sourceType = .photoLibrary
            
            // Make sure ViewController is notified when the user picks an image.
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer) { //Hide the keyboard
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view controller that lets a user pick media from their photo library
    let imagePickerController = UIImagePickerController()
        
        //Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
//MARK: Priavte Methods
    
    private func updateSaveButtonState(){
        // Disable the save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

