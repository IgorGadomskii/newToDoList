

import UIKit

class MoreInfoViewController: UIViewController {
    
    var task = newTask.shared()
    
    var name: String!
    var color: UIColor!
    var date: Date!


    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskTag: UIView!
    @IBOutlet weak var taskDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        taskTag.layer.cornerRadius = 30
        taskName.text = name
        taskTag.backgroundColor = color
        taskDate.text = date.description
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        performSegue(withIdentifier: "saveEditedTask", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveEditedTask" {
            guard let firstDestination = segue.destination as? MainViewController else { return }
            firstDestination.segueFromViewController = "saveEditedTask"
            firstDestination.task = task
        } else if segue.identifier == "editTask" {
            guard let destination = segue.destination as? NewTaskViewController else { return }
                   destination.segueFromViewController = "editTask"
                   destination.task.name = name
                   destination.task.date = date
                   destination.task.tagColor = color
        }
       
    }
    
    @IBAction func editData(for unwindSegue: UIStoryboardSegue, sender: Any?) {
        guard unwindSegue.identifier == "editNewTask" else {return}
        guard let source = unwindSegue.source as? NewTaskViewController else {return}
        task = source.task
        taskName.text = task.name
        taskDate.text = task.date.description
        taskTag.backgroundColor = task.tagColor
    }
    
}
