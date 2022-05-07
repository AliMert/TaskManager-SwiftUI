//
//  TaskDashboardViewModel.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import Foundation

class TaskDashboardViewModel: ObservableObject, CustomSegmentedBarProtocol {
    let tabs: [CustomSegmentedBarItem]
    @Published var currentTab: CustomSegmentedBarItem
    @Published var openEditTask: Bool = false

    init() {
        tabs = [.init("Today"), .init("Upcoming"), .init("Task Done")]
        currentTab = tabs[0]
    }
}
