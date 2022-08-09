

import UIKit

class NewTaskViewController: UIViewController {
    
    var task = newTask.shared()
    
    
    @IBOutlet weak var newTaskTextField: UITextField!
    @IBOutlet weak var newTaskTimePicker: UIDatePicker!

    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redButton.layer.cornerRadius = 20
        yellowButton.layer.cornerRadius = 20
        greenButton.layer.cornerRadius = 20
        blueButton.layer.cornerRadius = 20
        
    }
    
    @IBAction func yellowButtonPressed(_ sender: Any) {
        task.tagColor = .yellow
    }
    
    @IBAction func redButtonPressed(_ sender: Any) {
        task.tagColor = .red
    }
    
    @IBAction func greenButtonPressed(_ sender: Any) {
        task.tagColor = .green
    }
    
    @IBAction func blueButtonPressed(_ sender: Any) {
        task.tagColor = .blue
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        task.date = newTaskTimePicker.date
        if newTaskTextField.text?.isEmpty == false {
            task.name = newTaskTextField.text
        } else { return }
        
    }

    

}
