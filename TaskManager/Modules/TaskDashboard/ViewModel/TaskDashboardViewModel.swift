//
//  TaskDashboardViewModel.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import Foundation

class TaskDashboardViewModel: ObservableObject, CustomSegmentedBarProtocol {
    let tabs: [CustomSegmentedBarItem] = [ .init("Today"), .init("Upcoming"), .init("Task Done")]
    @Published var currentTab: CustomSegmentedBarItem

    init() {
        currentTab = tabs[0]
    }


    @Published var openEditTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskType: String = "Basic"
    @Published var taskDeadline: Date = Date()
}
