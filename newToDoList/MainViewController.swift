

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var taskList: [String] = []
   
    
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskTable: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTable.delegate = self
        taskTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        
        let task = taskList[indexPath.row]
        content.text = task
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    @IBAction func addNewTaskButton(_ sender: UIButton) {
        let alertNotification = UIAlertController.init(title: "Add new Task", message: "Please enter new task", preferredStyle: .alert)
        alertNotification.addTextField()
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let textField = alertNotification.textFields?.first
            if let newTask = textField?.text {
                self.taskList.append(newTask)
                self.taskTable.reloadData()
            }
        }
        
        alertNotification.addAction(saveAction)
        alertNotification.addAction(cancelAction)
        
        present(alertNotification, animated: true)
    }
    

}
