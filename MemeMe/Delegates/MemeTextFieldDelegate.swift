//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Filipe Botti on 07/11/18.
//  Copyright © 2018 Filipe Botti. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if let text = textField.text {
            
            if text == "TOP" || text == "BOTTOM" {
                textField.text = ""
            }
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: MemeNotificatonKeys.userDidEditMeme), object: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
}
