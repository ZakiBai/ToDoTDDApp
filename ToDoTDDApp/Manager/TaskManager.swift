//
//  TaskManager.swift
//  ToDoTDDApp
//
//  Created by Zaki on 16.08.2023.
//

import Foundation

class TaskManager {
    var tasksCount = 0
    var doneTasksCount = 0
    
    func add(task: Task) {
        tasksCount += 1
    }
    
    func task(at: Int) -> Task {
        return Task(title: "")
    }
}
