//
//  ViewController.swift
//  ToDoTDDApp
//
//  Created by Zaki on 15.08.2023.
//

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet var dataProvider: DataProvider!
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController {
            viewController.taskManager = self.dataProvider.taskManager
            present(viewController, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let taskManager = TaskManager()
        dataProvider.taskManager = taskManager
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
}

