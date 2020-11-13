//
//  Team.swift
//  TableView1
//
//  Created by Giray Uçar on 12.11.2020.
//  Copyright © 2020 Ahmet Giray Uçar. All rights reserved.
//

import Foundation
import UIKit

class Team {
    var name : String
    var image : UIImage
    var cups : Int
    
    init(name:String,image:UIImage,cups:Int) {
        self.cups = cups
        self.image = image
        self.name = name
    }
    
}
