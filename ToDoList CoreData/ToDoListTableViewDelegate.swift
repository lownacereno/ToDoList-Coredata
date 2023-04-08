import UIKit

class ToDoListTableViewDelegate : NSObject{
    var viewController: ToDoListViewController?
}

extension ToDoListTableViewDelegate: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = viewController else {return}
        
        if vc.tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            vc.tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            vc.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        vc.taskList[indexPath.row].completed = !vc.taskList[indexPath.row].completed
        vc.saveTask()
        
        vc.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let vc = viewController else {return UISwipeActionsConfiguration()}
        let deleteAction = UIContextualAction(style: .normal, title: "Eliminar") { _, _, _ in
            
            
            vc.bodyTask.delete(vc.taskList[indexPath.row])
            
            vc.taskList.remove(at: indexPath.row)
            
            vc.saveTask()
            
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
