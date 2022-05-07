//
//  AddNewTaskView.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import SwiftUI

struct AddNewTaskView: View {
    @StateObject private var viewModel = AddNewTaskViewModel()

    // MARK: All Environment Values in one Variable
    @Environment(\.dismiss) private var dismiss
    @Namespace private var animation

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(spacing: 12) {
                    Text("Edit Task")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .overlay(alignment: .leading) {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "arrow.left")
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                        }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Task Color")
                            .font(.caption)
                            .foregroundColor(.gray)

                        // MARK: Sample Card Colors
                        let colors: [String] = ["Yellow", "Green", "Blue", "Purple", "Red", "Orange"]

                        HStack(spacing: 15) {
                            ForEach(colors, id: \.self) { color in
                                Circle()
                                    .fill(Color(color))
                                    .frame(width: 25, height: 25)
                                    .background {
                                        if viewModel.taskColor == color {
                                            Circle()
                                                .strokeBorder(.gray)
                                                .padding(-3)
                                        }
                                    }
                                    .contentShape(Circle())
                                    .onTapGesture {
                                        viewModel.taskColor = color
                                    }
                            }
                        }
                        .padding(.top, 10)
                    }
                    .hLeading()
                    .padding(.top, 30)

                    Divider()
                        .padding(.vertical, 10)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Task Deadline")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text(viewModel.taskDeadline.formatted(date: .abbreviated, time: .omitted) + ", " + viewModel.taskDeadline.formatted(date: .omitted, time: .shortened))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .padding(.top,8)
                    }
                    .hLeading()
                    .overlay(alignment: .bottomTrailing) {
                        Button {
        //                    viewModel.showDatePicker.toggle()
                        } label: {
                            Image(systemName: "calendar")
                                .foregroundColor(.black)
                        }
                    }

                    Divider()
                        .padding(.vertical, 10)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Task Title")
                            .font(.caption)
                            .foregroundColor(.gray)

                        TextField("", text: $viewModel.taskTitle)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 10)
                    }

                    Divider()
                        .padding(.vertical, 10)

                    // MARK: Sample Task Types
                    let taskTypes: [String] = ["Basic", "Urgent", "Important"]
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Task Type")
                            .font(.caption)
                            .foregroundColor(.gray)

                        HStack(spacing: 12) {
                            ForEach(taskTypes,id: \.self) { type in
                                Text(type)
                                    .font(.callout)
                                    .padding(.vertical,8)
                                    .maxWidth()
                                    .foregroundColor(viewModel.taskType == type ? .white : .black)
                                    .background {
                                        if viewModel.taskType == type {
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "TYPE", in: animation)
                                        } else {
                                            Capsule()
                                                .strokeBorder(.black)
                                        }
                                    }
                                    .contentShape(Capsule())
                                    .onTapGesture {
                                        withAnimation{
                                            viewModel.taskType = type
                                        }
                                    }
                            }
                        }
                        .padding(.top, 8)
                    }

                    Divider()
                        .padding(.vertical,10)


                    // MARK: Save Button
                    VStack {
                        Spacer()

                        Button {

                        } label: {
                            Text("Save Task")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .maxWidth()
                                .padding(.vertical, 12)
                                .foregroundColor(.white)
                                .background {
                                    Capsule()
                                        .fill(.black)
                                }
                        }
                        .vBottom()
                    .padding(.vertical, 10)
                    }
                }
                .padding()
                .frame(minHeight: geometry.size.height)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct AddNewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskView()
    }
}
