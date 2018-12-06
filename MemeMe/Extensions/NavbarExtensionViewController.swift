//
//  NavbarExtensionViewController.swift
//  MemeMe
//
//  Created by Filipe Botti on 04/12/18.
//  Copyright © 2018 Filipe Botti. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setNavTitleAndButton() {
        self.navigationItem.title = "Sent Memes"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(newMeme))
    }
    
    @objc func newMeme() {
        performSegue(withIdentifier: MemeSegueKeys.newMemeSegue.rawValue, sender: self)
    }
}
