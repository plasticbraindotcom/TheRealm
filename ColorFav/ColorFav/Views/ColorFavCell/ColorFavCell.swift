//
//  ColorFavCell.swift
//  ColorFav
//
//  Created by Stephen Martinez on 7/16/18.
//  Copyright © 2018 Stephen Martinez. All rights reserved.
//

import UIKit

class ColorFavCell : UITableViewCell {
    
    @IBOutlet weak var colorView: ColorView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hexLabel: UILabel!
    
    static let sbid = "ColorFavCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func defaulSetUp() {
        colorView.shiftTo(0.5, 0.5, 0.5)
        nameLabel.text = "Gray Color"
        hexLabel.text = "000000"
    }
    
}
