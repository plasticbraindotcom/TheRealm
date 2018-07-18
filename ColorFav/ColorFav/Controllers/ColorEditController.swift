//
//  ColorEditController.swift
//  ColorFav
//
//  Created by Stephen Martinez on 7/17/18.
//  Copyright © 2018 Stephen Martinez. All rights reserved.
//

import UIKit

class ColorEditController: UIViewController {
    
    @IBOutlet weak var colorView: ColorView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var hexValueLabel: UILabel!
    
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    static let sbid = "ColorEditController"
    
    weak var colorRequestor: ColorRetrievable?
    
    var existingColor: FavColor!
    
    static func activate(
        from loadingPoint: UIViewController,
        colorRequestor: ColorRetrievable,
        setToColor: FavColor
        ) {
        guard let navController = loadingPoint.navigationController else { return }
        guard let colorEditController = loadingPoint.storyboard?.instantiateViewController(
            withIdentifier: ColorEditController.sbid) as? ColorEditController else { return }
        colorEditController.colorRequestor = colorRequestor
        colorEditController.existingColor = setToColor
        navController.pushViewController(colorEditController, animated: true)
    }
    
    func setUpWithExistingColor(){
        guard let color = existingColor else { return }
        let red = color.red
        let green = color.green
        let blue = color.blue
        let d = ColorHelper.toDecimal(r: red, g: green, b: blue)
        colorView.shiftTo(red, green, blue)
        redSlider.setValue(red, animated: false)
        greenSlider.setValue(green, animated: false)
        blueSlider.setValue(blue, animated: false)
        nameField.text = color.name
        redValue.text = "\(d.red)"
        greenValue.text = "\(d.green)"
        blueValue.text = "\(d.blue)"
        hexValueLabel.text = color.hex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        setUpStyle()
        setUpWithExistingColor()
        subscribeToKeyboardNotifications()
    }
    
    @IBAction func didChangeColor(_ sender: Any) {
        updateUI(
            red: redSlider.value,
            green: greenSlider.value,
            blue: blueSlider.value)
    }
    
    @IBAction func cancelColor(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func editColor(_ sender: Any) {
        
        guard let existingColor = existingColor else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        existingColor.red = redSlider.value
        existingColor.green = greenSlider.value
        existingColor.blue = blueSlider.value
        existingColor.name = nameField.text
        
        colorRequestor?.didEdit(color: existingColor)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteColor(_ sender: Any) {
        
        colorRequestor?.didDelete(color: existingColor)
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    func setUpStyle() {
        deleteButton.layer.cornerRadius = 10
        deleteButton.layer.borderColor = UIColor.red.cgColor
        deleteButton.layer.borderWidth = 2.5
        
        let pHolderText = NSAttributedString(
            string: "Enter Color Name",
            attributes: [
                .font : UIFont.futuraMedium(pt: 18),
                .foregroundColor : UIColor.lightGray])
        
        nameField.attributedPlaceholder = pHolderText
    }
    
    func updateUI(red: Float, green: Float, blue: Float) {
        colorView.shiftTo(red, green, blue)
        let decimal = ColorHelper.toDecimal(r: red, g: green, b: blue)
        self.redValue.text = String(decimal.red)
        self.greenValue.text = String(decimal.green)
        self.blueValue.text = String(decimal.blue)
        self.hexValueLabel.text = ColorHelper.toHexRGB(r: decimal.red, g: decimal.green, b: decimal.blue)
    }
    
}



//Textfield Management
extension ColorEditController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


//Keyboard Management
extension ColorEditController {
    
    private func keyboardClearance(up: Bool, by: CGFloat? = nil) {
        if up {
            guard let clearance = by else { return }
            UIView.animate(
                withDuration: 1,
                delay: 0,
                options: [ .curveEaseOut ],
                animations: { [view] in view?.frame.origin.y = 0 - clearance} )
        } else {
            UIView.animate(
                withDuration: 1,
                delay: 0,
                options: [ .curveEaseOut ],
                animations: { [view] in view?.frame.origin.y = 0 } )
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        keyboardClearance(up: true, by: keyboardFrame.height)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        keyboardClearance(up: false)
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}



