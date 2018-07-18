//
//  FavColor.swift
//  ColorFav
//
//  Created by Stephen Martinez on 7/16/18.
//  Copyright © 2018 Stephen Martinez. All rights reserved.
//

import UIKit

class FavColor {
    
    var red: Float
    var green: Float
    var blue: Float
    var name: String?
    var colorID = UUID().uuidString
    
    var hex: String {
        let my = ColorHelper.toDecimal(r: red, g: green, b: blue)
        return ColorHelper.toHexRGB(r: my.red, g: my.green, b: my.blue)
    }
    
    init(r: Float, g: Float, b: Float, name: String? = nil) {
        self.red = r
        self.green = g
        self.blue = b
        self.name = name
    }
    
}
