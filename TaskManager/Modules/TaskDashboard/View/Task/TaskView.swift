//
//  TaskView.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 8.05.2022.
//

import SwiftUI

struct TaskView: View {
    let currentTab: CustomSegmentedBarType
    @ObservedObject var viewModel: TaskDashboardViewModel
    var body: some View {

        LazyVStack(spacing: 20) {
            DynamicFilteredView(
                sortDescriptors: TaskSort.getSortDescriptors(with: currentTab),
                predicate: TaskSort.getPredicate(with: currentTab)
            ) { (task: Task) in
                TaskRowView(task: task, currentTab: currentTab) { task in
                    viewModel.editTask = task
                    viewModel.openEditTask = true
                }
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(currentTab: .today, viewModel: .init())
    }
}
