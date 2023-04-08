import UIKit

class ToDoListTableViewDataSource : NSObject{
    weak var viewController: ToDoListViewController?
}

extension ToDoListTableViewDataSource: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vc = viewController?.taskList.count else {return 0}
        return vc
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = viewController?.tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) else {return UITableViewCell()}
        guard let task = viewController?.taskList[indexPath.row] else {return UITableViewCell()}
        var listContentConfiguration = UIListContentConfiguration.cell()
        listContentConfiguration.text = task.taskName
                listContentConfiguration.textProperties.color = task.completed ? .black : .blue
        listContentConfiguration.secondaryText = task.completed ? "Completada" : "Por completar"
        listContentConfiguration.image = UIImage(systemName: "list.bullet.rectangle")
        cell.contentConfiguration = listContentConfiguration
        cell.accessoryType = task.completed ? .checkmark : .none
        return cell
    
    }
}
