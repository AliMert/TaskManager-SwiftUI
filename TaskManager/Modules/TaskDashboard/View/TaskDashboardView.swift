//
//  TaskDashboardView.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import SwiftUI

struct TaskDashboardView: View {

    @StateObject var viewModel: TaskDashboardViewModel
    @Namespace var animation: Namespace.ID

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome Back")
                        .font(.callout)

                    Text("Here's Update Today")
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                CustomSegmentedBar(delegate: viewModel, animation: animation)
                    .padding(.top, 5)

                // MARK: Task View

            }
            .padding()
        }
        .overlay(alignment: .bottom) {

            // MARK: Add Button
        }
    }
}

struct TaskDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskDashboardView(viewModel: .init())
                .navigationTitle("Task Manager")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
