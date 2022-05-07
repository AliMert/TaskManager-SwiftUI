//
//  TaskDashboardViewModel.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import Foundation

class TaskDashboardViewModel: ObservableObject, CustomSegmentedBarProtocol {
    @Published var currentTab: String = "Today"
    let tabs = ["Today", "Upcoming", "Task", "Done"]

}
