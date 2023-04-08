import UIKit

class ToDoListTableViewDelegate : NSObject{
    var viewController: ToDoListViewController?
}

extension ToDoListTableViewDelegate: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
