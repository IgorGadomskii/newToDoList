

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var task = newTask.shared()
    var taskList: [newTask] = []
    
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskTable: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskButton.layer.cornerRadius = 25
        
        taskTable.delegate = self
        taskTable.dataSource = self
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
    
    @IBAction func saveNewData(for unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "taskTable" else {return}
        guard let source = unwindSegue.source as? NewTaskViewController else {return}
        task = source.task
        taskList.insert(task, at: 0)
        taskTable.reloadData()
    }
    
    @IBAction func addNewTaskButton(_ sender: UIButton) {
    }
}
