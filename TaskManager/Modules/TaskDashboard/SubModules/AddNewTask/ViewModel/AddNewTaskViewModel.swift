//
//  AddNewTaskViewModel.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import Foundation
import CoreData

class AddNewTaskViewModel: ObservableObject {
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskType: String = "Basic"
    @Published var taskDeadline: Date = Date()
    @Published var showDatePicker = false
    var editTask: Task?

    init(editTask: Task?) {
        self.editTask = editTask
    }

    // MARK: Adding or Updating Task to Core Data
    func upsertTask(context: NSManagedObjectContext) -> Bool {
        let task = editTask ?? Task(context: context)

        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadline
        task.type = taskType
        task.isCompleted = false

        // MARK: Notifying VM's listeners to update UI
        if let _ = try? context.save() {
            objectWillChange.send()
            return true
        }
        return false
    }

    func deleteTask(task: Task, context: NSManagedObjectContext) {
        context.delete(task)
        try? context.save()
    }

    // MARK: Resetting Data
    func resetTaskData() {
        taskType = "Basic"
        taskColor = "Yellow"
        taskTitle = ""
        taskDeadline = Date()
    }

    func setup() {
        guard let task = editTask else {
            return
        }

        taskType = task.type ?? "Basic"
        taskColor = task.color ?? "Yellow"
        taskTitle = task.title ?? ""
        taskDeadline = task.deadline ?? Date()
    }
}
