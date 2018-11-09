//
//  ViewController.swift
//  MemeMe
//
//  Created by Filipe Botti on 06/11/18.
//  Copyright © 2018 Filipe Botti. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    let memeTextAttributes:[NSAttributedString.Key:Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -2
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        setTextFieldProperties(self.topText)
        setTextFieldProperties(self.bottomText)
        self.topText.text = "TOP"
        self.topText.textColor = UIColor.white
        self.bottomText.text = "BOTTOM"
        
        self.shareButton.isEnabled = false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setTextFieldProperties(_ textField: UITextField) {
        textField.delegate = memeTextFieldDelegate
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromNotifications()
    }
    
    func subscribeToNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDidEditMeme), name: NSNotification.Name(rawValue: MemeNotificatonKeys.userDidEditMeme), object: nil)

    }
    
    func unsubscribeFromNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: MemeNotificatonKeys.userDidEditMeme), object: nil)
    }
    
    @objc func userDidEditMeme() {
        if self.topText.text != "TOP" && self.bottomText.text != "BOTTOM" && self.imagePickerView.image != nil {
            shareButton.isEnabled = true
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }

    @IBAction func pickAnImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickFromCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
        }
        
        dismiss(animated: true, completion: nil)
        userDidEditMeme()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        bottomToolbar.isHidden = true
        topToolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        bottomToolbar.isHidden = false
        topToolbar.isHidden = false
        
        return memedImage
    }
    
    @IBAction func share(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
//        activityController.completionWithItemsHandler = { activity, success, items, error in
//            self.save()
//        }
        
        present(activityController, animated: true, completion: nil)
    }
    @IBAction func cancelEdit(_ sender: Any) {
        self.topText.text = "TOP"
        self.bottomText.text = "BOTTOM"
        self.imagePickerView.image = nil
        self.shareButton.isEnabled = false
    }
}

