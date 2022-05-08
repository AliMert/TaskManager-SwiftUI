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

    // MARK: Editing Existing Task Data
    var editTask: Task?

    init() {
        tabs = CustomSegmentedBarType.allCases.map { CustomSegmentedBarItem($0.rawValue) }
        currentTab = tabs[0]
    }
}
