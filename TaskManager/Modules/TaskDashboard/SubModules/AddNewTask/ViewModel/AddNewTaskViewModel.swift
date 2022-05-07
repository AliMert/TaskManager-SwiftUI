//
//  AddNewTaskViewModel.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import Foundation

class AddNewTaskViewModel: ObservableObject {
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskType: String = "Basic"
    @Published var taskDeadline: Date = Date()
}
