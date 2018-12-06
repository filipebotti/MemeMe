//
//  SentMemeTableViewController.swift
//  MemeMe
//
//  Created by Filipe Botti on 03/12/18.
//  Copyright © 2018 Filipe Botti. All rights reserved.
//

import UIKit

class SentMemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memedImage: UIImageView!
    @IBOutlet weak var memedTitle: UILabel!
}

class SentMemeTableViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var selectedMeme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavTitleAndButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let table = table {
            table.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appDelegate.memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeTableCell", for: indexPath) as! SentMemeTableViewCell
        
        let meme = appDelegate.memes[indexPath.row]
        cell.memedImage?.image = meme.memedImage
        cell.memedTitle?.text = "\(meme.topText)..\(meme.bottomText)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
