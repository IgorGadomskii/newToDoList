

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var name: String!
    var date: Date!
    var color: String!
    
    var taskList = StorageManager.shared.taskList
    let context = StorageManager.shared.context
    
    var doneTaskList: [NewTask] = []
    
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskButton.layer.cornerRadius = 35
        taskTableView.delegate = self
        taskTableView.dataSource = self

        fetchData()
        taskTableView.reloadData()
    }
    
    
    @IBAction func saveNewData(for unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "saveEditedTask" {
            if let indexPath = taskTableView.indexPathForSelectedRow {
                let task = taskList[indexPath.row]
                StorageManager.shared.edit(name, date, color, for: task)
            }
            taskTableView.reloadData()
        } else if unwindSegue.identifier == "saveNewTask" {
            guard let source = unwindSegue.source as? NewTaskViewController else {return}
            name = source.newName
            date = source.newDate
            color = source.hexColor
            save(name, date, color)
            taskTableView.reloadData()
        }
    }

    
    @IBAction func addNewTask(_ sender: UIButton) {
          performSegue(withIdentifier: "addNewTask", sender: self)
      }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         taskList.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCustomTableViewCell
        let task = taskList[indexPath.row]
        cell.taskLabel.text = task.name
        cell.colorTegView.backgroundColor = UIColor(hex: task.color ?? "")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction.init(style: .normal, title: "Done") { _,_,_ in
            let doneTask = self.taskList.remove(at: indexPath.row)
            self.doneTaskList.insert(doneTask, at: 0)
            self.taskTableView.deleteRows(at: [indexPath], with: .fade)
        }
        return UISwipeActionsConfiguration.init(actions: [doneAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction.init(style: .destructive, title: "Delete") { _, _, _ in
            let task = self.taskList[indexPath.row]
            StorageManager.shared.delete(task)
            self.taskList.remove(at: indexPath.row)
            self.taskTableView.deleteRows(at: [indexPath], with: .fade)
        }
        return UISwipeActionsConfiguration.init(actions: [deleteAction])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fullInfo", sender: self)
    }
  
}



extension MainViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let indexPath = taskTableView.indexPathForSelectedRow {
                guard let destination = segue.destination as? MoreInfoViewController else { return }
                let interstedTask = taskList[indexPath.row]
                destination.name = interstedTask.name
                destination.color = interstedTask.color
                destination.date = interstedTask.date
        }
    }
    
    private func fetchData() {
            StorageManager.shared.fetchData(completion: {result in
                switch result {
                case .success(let taskList):
                    self.taskList = taskList
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    
    
    private func save(_ taskName: String, _ taskDate: Date, _ taskColor: String) {
        StorageManager.shared.save(taskName, taskDate, taskColor) { task in
            taskList.insert(task, at: 0)
            let cellIndex = IndexPath(row: taskList.count - 1 , section: 0)
            self.taskTableView.insertRows(at: [cellIndex], with: .automatic)
        }
    }
    
}



