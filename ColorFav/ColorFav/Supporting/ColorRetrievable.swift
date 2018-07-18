//
//  ColorRetrievable.swift
//  ColorFav
//
//  Created by Stephen Martinez on 7/17/18.
//  Copyright © 2018 Stephen Martinez. All rights reserved.
//

import UIKit

protocol ColorRetrievable: AnyObject {
    
    func didSave(color: FavColor)
    
    func didEdit(color: FavColor)
    
    func didDelete(color: FavColor)
    
}
