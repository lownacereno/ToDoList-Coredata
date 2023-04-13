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
        listContentConfiguration.image = UIImage(systemName: "list.bullet.rectangle")
        if task.completed == true{
            listContentConfiguration.secondaryText = "Completada"
            listContentConfiguration.textProperties.color = .black
            cell.accessoryType = .checkmark
        }else{
            listContentConfiguration.secondaryText = "Por completar"
            listContentConfiguration.textProperties.color = .blue
            cell.accessoryType = .none
        }
        cell.contentConfiguration = listContentConfiguration
        return cell
        
    }
}
