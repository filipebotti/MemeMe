//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Filipe Botti on 03/12/18.
//  Copyright © 2018 Filipe Botti. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SentMemeCollectionCell"

class SentMemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memeImage: UIImageView!
    
}

class SentMemeCollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var selectedMeme: Meme!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        setNavTitleAndButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.collectionView!.reloadData()
    }
    


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return appDelegate.memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SentMemeCollectionViewCell
        
        cell.memeImage?.image = appDelegate.memes[indexPath.row].memedImage  
        
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMeme = appDelegate.memes[indexPath.row]
        performSegue(withIdentifier: MemeSegueKeys.showMemeSegue.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == MemeSegueKeys.showMemeSegue.rawValue) {
            let controller = segue.destination as! ShowMemeViewController
            controller.meme = selectedMeme
        }
    }
}
