//
//  Task.swift
//  ToDoTDDApp
//
//  Created by Zaki on 15.08.2023.
//

import Foundation

struct Task {
    let title: String
    let description: String?
    let date: Date
    let location: Location?
    
    
    init(title: String, description: String? = nil, date: Date? = nil, location: Location? = nil ) {
        self.title = title
        self.description = description
        self.date = date ?? Date()
        self.location = location
    }
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        if lhs.title == rhs.title, lhs.location == rhs.location, lhs.description == rhs.description {
            return true
        }
        return false
    }
}
