//
//  DetailViewController.swift
//  TableView1
//
//  Created by Giray Uçar on 12.11.2020.
//  Copyright © 2020 Ahmet Giray Uçar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label1: UILabel!
    
    var selectedTeam : Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = selectedTeam?.name
        imageView.image = selectedTeam?.image
    }
    
}
