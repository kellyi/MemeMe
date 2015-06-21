//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Kelly Innes on 6/13/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    // MARK: - Set TextField Attributes
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
        ]

    // track state of TextField currently accepting text
    
    var currentTextFieldName: String!
    
    // MARK: - View Setup
    
    // format TextFields, setup notifications, and enable/disable buttons on load
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setMemeTextAttributes()
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        shareButton.enabled = memeImageView.image != nil
        subscribeToKeyboardNotifications()
    }
    
    // stop listening for keyboardNotifications when view isn't on screen
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: - IBActions

    // pop view off stack
    @IBAction func cancelNewMeme(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // share and save meme
    @IBAction func shareNewMeme(sender: UIButton) {
        let memeToShareAndSave = generateMemedImage()
        let objectsToShare = [memeToShareAndSave]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.presentViewController(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = {(activityType: String!, completed:Bool, obj: [AnyObject]!, error: NSError!) in
            if completed { self.save(memeToShareAndSave) }
        }
    }
    
    // call modular newMemeFromSource method with camera
    @IBAction func newMemeFromCamera(sender: UIButton) {
        newMemeFromSource("camera")
    }
    
    // call newMemeFromSource method with album
    @IBAction func newMemeFromAlbum(sender: UIButton) {
        newMemeFromSource("album")
    }
    
    // MARK: - Create, Format, and Save Memes
    
    // DRY for newMeme methods
    func newMemeFromSource(source: NSString) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source == "camera" ? UIImagePickerControllerSourceType.Camera : UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // save meme with shared model
    func save(memedImage: UIImage) {
        var meme = Meme(top: topTextField.text!, bottom: bottomTextField.text!, originalImage: memeImageView.image!, newImage: memedImage)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    // hide navbar and toolbar, take a screenshot, save that image
    // then unhide navbar and toolbar
    func generateMemedImage() -> UIImage {
        navBar.hidden = true
        toolBar.hidden = true
    
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navBar.hidden = false
        toolBar.hidden = false
        return memedImage
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    // dismiss ImagePicker when an image has been chosen
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageView.image = image
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // dismiss ImagePicker on cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Keyboard and TextField Functions
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // move view up by specified value on receiving notification
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    // move view down by specified value on receiving notification
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    // clear default text when editing starts, set state variable to note currently edited TextField
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
        currentTextFieldName = textField == bottomTextField ? "bottom" : "top"
    }
    
    // return amount to move view up: 0 if the topTextField's being edited, keyboard height if the bottomTextField's being edited
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        // don't move keyboard up if entering text into the topTextField
        if currentTextFieldName == "top" {
            return CGFloat(0.0)
        }
        // do move keyboard up if entering text into the bottomTextField
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // restore default text if user doesn't enter any new text
    // capitalize and style any lowercase letters the user entered
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text == "" {
            if textField == topTextField {
                textField.text = "TOP"
            } else {
                textField.text = "BOTTOM"
            }
        }
        setMemeTextAttributes()
        self.view.endEditing(true)
        return false
    }
    
    // reusable method to set the memetext attributes
    func setMemeTextAttributes() {
        //topTextField.textAlignment = NSTextAlignment.Center
        //bottomTextField.textAlignment = NSTextAlignment.Center
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.text = topTextField.text.uppercaseString
        bottomTextField.text = bottomTextField.text.uppercaseString
    }
}
