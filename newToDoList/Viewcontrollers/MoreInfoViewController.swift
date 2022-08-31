

import UIKit

class MoreInfoViewController: UIViewController {
    

    
    var name: String!
    var color: String!
    var date: Date!


    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskTagView: UIView!
    @IBOutlet weak var taskDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        taskTagView.layer.cornerRadius = 30
        
        taskNameLabel.text = name
        taskTagView.backgroundColor = UIColor(hex: color)
        taskDateLabel.text = date.description
       
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        performSegue(withIdentifier: "saveEditedTask", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveEditedTask" {
            guard let firstDestination = segue.destination as? MainViewController else { return }
                firstDestination.date = date
                firstDestination.color = color
                firstDestination.name = taskNameLabel.text
        } else if segue.identifier == "editTask" {
            guard let destination = segue.destination as? NewTaskViewController else { return }
                destination.segueFromViewController = "editTask"
                destination.newName = taskNameLabel.text
                destination.newDate = date
                destination.hexColor = color
        }
    }
    
    
    @IBAction func editData(for unwindSegue: UIStoryboardSegue, sender: Any?) {
        guard let source = unwindSegue.source as? NewTaskViewController else {return}
        name = source.newName
        color = source.hexColor
        date = source.newDate
        viewDidLoad()
    }
}
