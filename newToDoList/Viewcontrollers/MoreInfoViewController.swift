

import UIKit

class MoreInfoViewController: UIViewController {
    
    var task = newTask.shared()
    
    var name: String!
    var color: UIColor!
    var date: Date!


    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskTagView: UIView!
    @IBOutlet weak var taskDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        taskTagView.layer.cornerRadius = 30
        taskNameLabel.text = name
        taskTagView.backgroundColor = color
        taskDateLabel.text = date.description
       
    }
    
   
    
    override func viewWillDisappear(_ animated: Bool) {
        performSegue(withIdentifier: "saveEditedTask", sender: self)
        print("1")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveEditedTask" {
            print("2")
            guard let firstDestination = segue.destination as? MainViewController else { return }
            firstDestination.segueFromViewController = "saveEditedTask"
//            firstDestination.task = task
            task.date = date
            task.tagColor = taskTagView.backgroundColor
            task.name = taskNameLabel.text
        } else if segue.identifier == "editTask" {
            guard let destination = segue.destination as? NewTaskViewController else { return }
                   destination.segueFromViewController = "editTask"
                destination.task.name = taskNameLabel.text
                destination.task.date = date
            destination.task.tagColor = taskTagView.backgroundColor
        }
       
    }
    
    @IBAction func editData(for unwindSegue: UIStoryboardSegue, sender: Any?) {
        guard unwindSegue.identifier == "editNewTask" else {return}
        guard let source = unwindSegue.source as? NewTaskViewController else {return}
        task = source.task
        taskNameLabel.text = task.name
        taskTagView.backgroundColor = task.tagColor
        taskDateLabel.text = task.date.description
    }
    
}
