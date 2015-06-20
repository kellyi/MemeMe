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

    // tracks state of TextField currently accepting text
    
    var currentTextFieldName: String!
    
    // MARK: - View Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setMemeTextAttributes()
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        shareButton.enabled = memeImageView.image != nil
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: - IBActions

    @IBAction func cancelNewMeme(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareNewMeme(sender: UIButton) {
        let memeToShareAndSave = generateMemedImage()
        let objectsToShare = [memeToShareAndSave]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.presentViewController(activityVC, animated: true, completion: nil)
        // TODO: save the image
        activityVC.completionWithItemsHandler = {(activityType: String!, completed:Bool, obj: [AnyObject]!, error: NSError!) in
            if !completed {
                return
            } else {
                self.save(memeToShareAndSave)
            }
        }
    }
    
    @IBAction func newMemeFromCamera(sender: UIButton) {
        newMemeFromSource("camera")
    }
    
    @IBAction func newMemeFromAlbum(sender: UIButton) {
        newMemeFromSource("album")
    }
    
    // MARK: - Create, Format, and Save Memes
    
    // DRY for IBActions from Camera && Album
    func newMemeFromSource(source: NSString) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source == "camera" ? UIImagePickerControllerSourceType.Camera : UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func createNewMeme(from: String) {
        println(from)
    }
    
    func save(memedImage: UIImage) {
        var meme = Meme(top: topTextField.text!, bottom: bottomTextField.text!, originalImage: memeImageView.image!, newImage: memedImage)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.memeImageView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
        currentTextFieldName = textField == bottomTextField ? "bottom" : "top"
    }
    
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // restore default text if user doesn't enter any new text
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
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.text = topTextField.text.uppercaseString
        bottomTextField.text = bottomTextField.text.uppercaseString
    }
}
