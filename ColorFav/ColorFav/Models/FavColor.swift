//
//  FavColor.swift
//  ColorFav
//
//  Created by Stephen Martinez on 7/16/18.
//  Copyright © 2018 Stephen Martinez. All rights reserved.
//

import UIKit
import RealmSwift

class FavColor: Object {
    
    @objc dynamic var red: Float = 0
    @objc dynamic var green: Float = 0
    @objc dynamic var blue: Float = 0
    @objc dynamic var name: String?
    @objc dynamic var colorID = UUID().uuidString
    @objc dynamic var timeStamp = Date().timeIntervalSinceReferenceDate
    
    var hex: String {
        let my = ColorHelper.toDecimal(r: red, g: green, b: blue)
        return ColorHelper.toHexRGB(r: my.red, g: my.green, b: my.blue)
    }
    
    convenience init(r: Float, g: Float, b: Float, name: String? = nil) {
        self.init()
        self.red = r
        self.green = g
        self.blue = b
        self.name = name
    }
    
    override static func primaryKey() -> String {
        return "colorID"
    }
    
}
