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

                NavigationLink(
                    destination:
                        AddNewTaskView().navigationBarHidden(true),
                    isActive: $viewModel.openEditTask,
                    label: {}
                )
            }
            .padding()
        }
        .overlay(alignment: .bottom) {

            // MARK: Add Button
            Button {
                viewModel.openEditTask = true
            } label: {
                Label {
                    Text("Add Task")
                } icon: {
                    Image(systemName: "plus.app.fill")

                }
                .font(.title3.bold())
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 20)
                .shadow(color: .black, radius: 0.5, x: 0.8, y: 0.5)
                .background {
                    Capsule()
                        .fill(Color("CustomSegmentedBarBackground"))
                        .shadow(color: Color(UIColor.label), radius: 0.9, x: 0.5, y: 0.5)

                }
            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity)
            // MARK: Linear Gradient BG
            .background{
                LinearGradient(
                    colors: [
                        Color(UIColor.systemGray5).opacity(0.05),
                        Color(UIColor.systemGray5).opacity(0.1),
                        Color(UIColor.systemGray5).opacity(0.4),
                        Color(UIColor.systemGray5).opacity(0.7),
                        Color(UIColor.systemGray5)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }
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
        .navigationViewStyle(.stack)
//        .preferredColorScheme(.dark)
    }
}
