//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 10/17/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    //this value is either passed by 'MealTableViewController' in 'prepare(for:sender:)' or constructed as part of adding a new meal
    var meal : Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
        updateSaveButtonState()
        
        //set up views if editting an existing meal
        if let meal = meal {
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
            navigationItem.title = meal.name
        }
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //disable the Save button while editing
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        nameTextField.resignFirstResponder()
        return true
    }
    
    //MARK: UIImagePickerViewControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //the info dictionary may contain multiple representations of the image. You want to use the original
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing a image , but was provided the following: \(info)")
        }
        
        //set the photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //this method lets you configure a view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //set the meal to be passed to MealTableViewController after the unwind segue
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //hide the keyboard
        nameTextField.resignFirstResponder()
        
        //UIPickerViewController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        //only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        //Make sure View Controller is notified when the user picks an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Private Actions
    private func updateSaveButtonState() {
        //Disable the Save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

