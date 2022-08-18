

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var task = newTask.shared()
    
    var taskList: [newTask] = []
    
    var segueFromViewController: String!
    
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskButton.layer.cornerRadius = 35
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
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
            if let indexPath = taskTableView.indexPathForSelectedRow {
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
            print("3")
            guard unwindSegue.identifier == "saveEditedTask" else { return }
            guard let source = unwindSegue.source as? MoreInfoViewController else { return }
            task = source.task
            if let indexPath = taskTableView.indexPathForSelectedRow {
                taskList.remove(at: indexPath.row)
                taskList.insert(task, at: indexPath.row)
            }
            taskTableView.reloadData()
        } else if segueFromViewController == "saveNewTask" {
            guard unwindSegue.identifier == "saveNewTask" else {return}
            guard let source = unwindSegue.source as? NewTaskViewController else {return}
            task = source.task
            taskList.insert(task, at: 0)
            taskTableView.reloadData()
        }
       }

    
    @IBAction func addNewTask(_ sender: UIButton) {
          performSegue(withIdentifier: "addNewTask", sender: self)
      }
    
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fullInfo", sender: self)
    }
    
    
  
}



