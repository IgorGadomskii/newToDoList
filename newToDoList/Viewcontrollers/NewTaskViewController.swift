

import UIKit

class NewTaskViewController: UIViewController {
    
    var task = newTask.shared()
    var segueFromViewController = "addNewTask"
    
//    var text = ""
//    var date = Date.now
//    var color = UIColor.gray
    
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
        
        newTaskTextField.text = task.name
        newTaskTimePicker.date = task.date
        mainTag.backgroundColor = task.tagColor
        
//        segueFromViewController
        
    }
    
    
    @IBAction func redTagButtonPressed(_ sender: UIButton) {
        mainTag.backgroundColor = .red
    }
    
    @IBAction func greenTagButtonPressed(_ sender: UIButton) {
        mainTag.backgroundColor = .green
    }
    
    @IBAction func blueTagButtonPressed(_ sender: UIButton) {
        mainTag.backgroundColor = .blue
    }
    
    @IBAction func yellowTagButtonPressed(_ sender: UIButton) {
        mainTag.backgroundColor = .yellow
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveNewTask" {
            guard let destination = segue.destination as? MainViewController else { return }
            destination.segueFromViewController = "saveNewTask"
            saveTask()
        } else if segue.identifier == "editNewTask" {
            saveTask()
        }
    }
    
    
    @IBAction func pressSaveButton(_ sender: UIButton) {
        if segueFromViewController == "addNewTask" {
            performSegue(withIdentifier: "saveNewTask", sender: self)
        } else if segueFromViewController == "editTask" {
            performSegue(withIdentifier: "editNewTask", sender: self)
        } 
    }
    
    private func saveTask() {
        task.tagColor = mainTag.backgroundColor
        task.date = newTaskTimePicker.date
        if newTaskTextField.text?.isEmpty == false {
            task.name = newTaskTextField.text
        } else { return }
    }
}
