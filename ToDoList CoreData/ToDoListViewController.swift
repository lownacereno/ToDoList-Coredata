import UIKit
import CoreData

class ToDoListViewController: UIViewController{
    
    let tableView = UITableView()
    private let dataSource : ToDoListTableViewDataSource?
    private let delegate : ToDoListTableViewDelegate?
    var taskList = [Task]()
    let bodyTask = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    init(dataSourceTable: ToDoListTableViewDataSource, delegateTable: ToDoListTableViewDelegate){
        self.dataSource = dataSourceTable
        self.delegate = delegateTable
        super.init(nibName: nil, bundle: nil)
        self.dataSource?.viewController = self
        self.delegate?.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableViewSetup()
        tableViewConstraints()
        readTask()
        navigationItem.title = "Tareas"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(newTask))
        
    }
    
    @objc func newTask(){
        var nameTaskEntry = UITextField()
        let alert = UIAlertController(title: "Nueva", message: "Tarea", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Agregar", style: .default) { (_) in
            let newTask = Task(context: self.bodyTask)
            newTask.taskName = nameTaskEntry.text
            newTask.completed = false
            self.taskList.append(newTask)
            self.saveTask()
        }
        alert.addTextField{ textFieldAlert in
            textFieldAlert.placeholder = "Escribe tu nota aquí"
            nameTaskEntry = textFieldAlert
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
 
    private func tableViewSetup(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        view.addSubview(tableView)
    }
    
    private func tableViewConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ToDoListViewController: ToDoListProtocol{
    func saveTask(){
        do{
            try bodyTask.save()
        }catch{
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
    }
    
    func readTask(){
        let solicitud : NSFetchRequest<Task> = Task.fetchRequest()
        do{
            taskList = try bodyTask.fetch(solicitud)
        }catch{
            print(error.localizedDescription)
        }
    }
}
