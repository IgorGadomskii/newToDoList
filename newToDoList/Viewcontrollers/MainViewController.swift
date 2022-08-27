

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var name: String!
    var date: Date!
    
    var taskList = StorageManager.shared.taskList
    let context = StorageManager.shared.context
    
    var doneTaskList: [NewTask] = []
    
    var segueFromViewController: String!
    
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskButton.layer.cornerRadius = 35
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        fetchData()
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
//                destination.color = UIColor(interstedTask.color)
                destination.date = interstedTask.date
            }
        }
    }
    
    
    @IBAction func saveNewData(for unwindSegue: UIStoryboardSegue) {
        if segueFromViewController == "saveEditedTask" {
            guard unwindSegue.identifier == "saveEditedTask" else { return }
            guard let source = unwindSegue.source as? MoreInfoViewController else { return }
            if let indexPath = taskTableView.indexPathForSelectedRow {
                name = source.name
                date = source.date
                let task = taskList[indexPath.row]
                StorageManager.shared.edit(name, date, for: task)
            }
            taskTableView.reloadData()
        } else if segueFromViewController == "saveNewTask" {
            guard unwindSegue.identifier == "saveNewTask" else {return}
            guard let source = unwindSegue.source as? NewTaskViewController else {return}
            name = source.newName
            date = source.newDate
            save(name, date)
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
        return cell
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
    
    private func save(_ taskName: String, _ taskDate: Date) {
        StorageManager.shared.save(taskName, taskDate) { task in
            taskList.insert(task, at: 0)
            let cellIndex = IndexPath(row: taskList.count - 1 , section: 0)
            self.taskTableView.insertRows(at: [cellIndex], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction.init(style: .normal, title: "Done") { _,_,_ in
            self.taskTableView.beginUpdates()
            let doneTask = self.taskList.remove(at: indexPath.row)
            self.doneTaskList.insert(doneTask, at: 0)
            self.taskTableView.deleteRows(at: [indexPath], with: .fade)
            self.taskTableView.endUpdates()
    
        }
        
        return UISwipeActionsConfiguration.init(actions: [doneAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction.init(style: .destructive, title: "Delete") { _, _, _ in
            self.taskTableView.beginUpdates()
            let task = self.taskList[indexPath.row]
            StorageManager.shared.delete(task)
            self.taskList.remove(at: indexPath.row)
            self.taskTableView.deleteRows(at: [indexPath], with: .fade)
            self.taskTableView.endUpdates()
        }
        
        return UISwipeActionsConfiguration.init(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fullInfo", sender: self)
    }
  
}



