

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var task = newTask.shared()
    var taskList: [newTask] = []
    var segueFromViewController: String!
    
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskTable: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskButton.layer.cornerRadius = 35
        
        taskTable.delegate = self
        taskTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCustomTableViewCell
        let task = taskList[indexPath.row]
        cell.taskLabel.text = task.name
        cell.colorTegView.backgroundColor = task.tagColor
        return cell
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewTask" {
            guard let firstDestination = segue.destination as? NewTaskViewController else {return}
            firstDestination.segueFromViewController = "addNewTask"
        } else if segue.identifier == "fullInfo" {
            if let indexPath = taskTable.indexPathForSelectedRow {
                guard let destination = segue.destination as? MoreInfoViewController else { return }
                let interstedTask = taskList[indexPath.row]
                destination.name = interstedTask.name
                destination.color = interstedTask.tagColor
                destination.date = interstedTask.date
            }
        }
    }
    
    
    
    
    @IBAction func saveNewData(for unwindSegue: UIStoryboardSegue) {
        if segueFromViewController == "saveEditedTask" {
            guard unwindSegue.identifier == "saveEditedTask" else { return }
            guard let source = unwindSegue.source as? MoreInfoViewController else { return }
            task = source.task
            taskTable.reloadData()
        } else if segueFromViewController == "saveNewTask" {
            guard unwindSegue.identifier == "saveNewTask" else {return}
            guard let source = unwindSegue.source as? NewTaskViewController else {return}
            task = source.task
            taskList.insert(task, at: 0)
            taskTable.reloadData()
        }
       }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fullInfo", sender: self)
    }
    
    
    @IBAction func addNewTask(_ sender: UIButton) {
        performSegue(withIdentifier: "addNewTask", sender: self)
    }
}



