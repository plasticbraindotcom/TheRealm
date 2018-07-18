//
//  ColorFavsController.swift
//  ColorFav
//
//  Created by Stephen Martinez on 7/16/18.
//  Copyright © 2018 Stephen Martinez. All rights reserved.
//

import UIKit

class ColorFavsController: UIViewController {
    
    @IBOutlet weak var colorFavsList: UITableView!
    
    var selectedPath = IndexPath(row: 0, section: 0)
    
    var colorList = [FavColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorFavsList.delegate = self
        colorFavsList.dataSource = self
    }
    
    @IBAction func createFavColor(_ sender: Any) {
        ColorSaveController.activate(from: self, colorRequestor: self)
    }
    
}

//TableView Methods
extension ColorFavsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let colorFavCell =
            Bundle.main.loadNibNamed(ColorFavCell.sbid,owner: self, options: nil)?.first as? ColorFavCell else {
            return UITableViewCell(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        }
        
        colorFavCell.colorView.shiftTo(colorList[indexPath.row].red, colorList[indexPath.row].green, colorList[indexPath.row].blue)
        colorFavCell.nameLabel.text = colorList[indexPath.row].name
        colorFavCell.hexLabel.text = colorList[indexPath.row].hex
        
        return colorFavCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        ColorEditController.activate(from: self, colorRequestor: self, setToColor: colorList[indexPath.row])
    }
    
}

//Saving Methods
extension ColorFavsController: ColorRetrievable {
    
    func didSave(color: FavColor) {
        colorList.insert(color, at: 0)
        let path = [IndexPath(row: 0, section: 0)]
        colorFavsList.insertRows(at: path, with: .left)
        print("did save was selected")
    }
    
    func didEdit(color: FavColor) {
        colorFavsList.reloadRows(at: [selectedPath], with: .fade)
        print("did edit was selected")
    }
    
    func didDelete(color: FavColor) {
        colorList.remove(at: selectedPath.row)
        colorFavsList.deleteRows(at: [selectedPath], with: .right)
        print("did delete was selected")
    }
    
}



