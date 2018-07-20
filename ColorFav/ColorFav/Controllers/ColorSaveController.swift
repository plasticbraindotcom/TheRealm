//
//  ColorSaveController.swift
//  ColorFav
//
//  Created by Stephen Martinez on 7/16/18.
//  Copyright © 2018 Stephen Martinez. All rights reserved.
//

import UIKit

class ColorSaveController: UIViewController {
    
    @IBOutlet weak var colorView: ColorView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var hexValueLabel: UILabel!
    
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    static let sbid = "ColorSaveController"
    weak var colorRequestor: ColorRetrievable?
    
    static func activate(
        from loadingPoint: UIViewController,
        colorRequestor: ColorRetrievable
        ) {
        guard let navController = loadingPoint.navigationController else { return }
        guard let colorSaveController = loadingPoint.storyboard?.instantiateViewController(
            withIdentifier: ColorSaveController.sbid) as? ColorSaveController else { return }
        colorSaveController.colorRequestor = colorRequestor
        navController.pushViewController(colorSaveController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        setUpStyle()
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
    
    @IBAction func saveColor(_ sender: Any) {
        let color = FavColor(
            r: redSlider.value,
            g: greenSlider.value,
            b: blueSlider.value,
            name: nameField.text)
        colorRequestor?.didSave(color: color)
        navigationController?.popViewController(animated: true)
    }
    
    func setUpStyle() {
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

// MARK: - Textfield Management
extension ColorSaveController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

// MARK: - Keyboard Management
extension ColorSaveController {
    
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












