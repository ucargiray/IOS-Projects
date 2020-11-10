//
//  ViewController.swift
//  Gesture Recognizer Project
//
//  Created by Giray Uçar on 10.11.2020.
//  Copyright © 2020 Ahmet Giray Uçar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label1: UILabel!
    
    var isNew = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecog = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        imageView.addGestureRecognizer(gestureRecog)
    }

    @objc func changeImage(){
        
        if isNew{
            isNew = false
            imageView.image = UIImage(named: "liverpool2")
            label1.text = "Old Liverpool Logo"
        }
        else {
            isNew = true
            imageView.image = UIImage(named: "liverpool1")
            label1.text = "New Liverpool Logo"
        }
    }

}

