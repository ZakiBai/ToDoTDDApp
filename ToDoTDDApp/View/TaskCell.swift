//
//  TaskCell.swift
//  ToDoTDDApp
//
//  Created by Zaki on 17.08.2023.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    func configure(withTask task: Task) {
    }
}
