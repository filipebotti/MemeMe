//
//  ShowMemeViewController.swift
//  MemeMe
//
//  Created by Filipe Botti on 05/12/18.
//  Copyright © 2018 Filipe Botti. All rights reserved.
//

import UIKit

class ShowMemeViewController: UIViewController {

    var meme: Meme!
    @IBOutlet weak var imageMemeView: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageMemeView.image = meme.memedImage
    }
    

}
