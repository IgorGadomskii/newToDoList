

import UIKit

class NewTaskViewController: UIViewController {
    
    var segueFromViewController = "addNewTask"
    
    var newName: String!
    var newDate: Date = Date.now
    var hexColor: String = "#E8E6E6"

    
    @IBOutlet weak var newTaskTextField: UITextField!
    @IBOutlet weak var newTaskTimePicker: UIDatePicker!

    @IBOutlet weak var mainTag: UIView!
    
    @IBOutlet weak var redTagButton: UIButton!
    @IBOutlet weak var greenTagButton: UIButton!
    @IBOutlet weak var blueTagButton: UIButton!
    @IBOutlet weak var yellowTagButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTag.layer.cornerRadius = 25
        
        redTagButton.layer.cornerRadius = 20
        yellowTagButton.layer.cornerRadius = 20
        greenTagButton.layer.cornerRadius = 20
        blueTagButton.layer.cornerRadius = 20
        
        newTaskTextField.text = newName
        newTaskTimePicker.date = newDate
        mainTag.backgroundColor = UIColor(hex: hexColor)
    }
    
    
    @IBAction func redTagButtonPressed(_ sender: UIButton) {
        hexColor = "#D61B1B"
        mainTag.backgroundColor = UIColor(hex: hexColor)
    }
    
    @IBAction func greenTagButtonPressed(_ sender: UIButton) {
        hexColor = "#46A055"
        mainTag.backgroundColor = UIColor(hex: hexColor)
    }
    
    @IBAction func blueTagButtonPressed(_ sender: UIButton) {
        hexColor = "#5E94E4"
        mainTag.backgroundColor = UIColor(hex: hexColor)
    }
    
    @IBAction func yellowTagButtonPressed(_ sender: UIButton) {
        hexColor = "#FFE91F"
        mainTag.backgroundColor = UIColor(hex: hexColor)
    }
    
    
    @IBAction func pressSaveButton(_ sender: UIButton) {
        newDate = newTaskTimePicker.date
        if newTaskTextField.text?.isEmpty == false {
            newName = newTaskTextField.text
        } else { return }
        if segueFromViewController == "addNewTask" {
            performSegue(withIdentifier: "saveNewTask", sender: self)
        } else if segueFromViewController == "editTask" {
            performSegue(withIdentifier: "editNewTask", sender: self)
            segueFromViewController = "addNewTask"
        }
    }
    
}
