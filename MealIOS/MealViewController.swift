//
//  ViewController.swift
//  MealIOS
//
//  Created by maisapride8 on 08/06/16.
//  Copyright © 2016 maisapride8. All rights reserved.
//

import UIKit

class MealViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    //MARKS: Variables,
    @IBOutlet weak var mealNameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingController!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var meal: Meal?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // mealLabel.text = "HELLO"
        
        mealNameTextField.delegate = self
      
        
        // set up views if editing an existing meal
        if let meal = meal{
            navigationItem.title = meal.name
            mealNameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
            }
        
          checkValidMealName()
        
    }
    
    //MARK: UITextFieldDelegate methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    func textFieldDidEndEditing(textField: UITextField) {
       checkValidMealName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    
    func checkValidMealName()
        {
            let text = mealNameTextField.text ?? ""
            saveButton.enabled = !text.isEmpty
        }
    //MARK: ImagePickerController Delegate.
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        mealNameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if saveButton === sender
        {
            let name = mealNameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            // now pass the meal to  MealTableViewController
            meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
    
    
    
    //MARK: Actions
    
    @IBAction func cancel(sender: UIBarButtonItem)
    {
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }else{
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    
  /*  @IBAction func save(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }*/
    
    
   
}

