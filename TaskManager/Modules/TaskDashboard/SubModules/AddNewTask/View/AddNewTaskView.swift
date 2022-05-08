//
//  AddNewTaskView.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import SwiftUI

struct AddNewTaskView: View {
    @StateObject private var viewModel: AddNewTaskViewModel

    // MARK: All Environment Values in one Variable
    @Environment(\.self) private var env
    @Namespace private var animation

    init(editTask: Task? = nil) {
        let viewModel = AddNewTaskViewModel(editTask: editTask)
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(spacing: 12) {
                    Text("Edit Task")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .overlay(alignment: .leading) {
                            Button {
                                env.dismiss()
                            } label: {
                                Image(systemName: "arrow.left")
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                        }
                        .overlay(alignment: .trailing) {
                            Button {
                                guard let editTask = viewModel.editTask else {
                                    return
                                }
                                viewModel.deleteTask(task: editTask, context: env.managedObjectContext)
                                env.dismiss()
                            } label: {
                                Image(systemName: "trash")
                                    .font(.title3)
                                    .foregroundColor(.red)
                            }
                            .opacity(viewModel.editTask == nil ? 0 : 1)
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
                            viewModel.showDatePicker.toggle()
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
                    Button {
                        // MARK: If Success Closing View
                        if viewModel.upsertTask(context: env.managedObjectContext) {
                            env.dismiss()
                        }
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
                    .disabled(viewModel.taskTitle == "")
                    .opacity(viewModel.taskTitle == "" ? 0.6 : 1)
                }
                .padding()
                .frame(minHeight: geometry.size.height)
                .overlay {
                    ZStack {
                        if viewModel.showDatePicker {
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    viewModel.showDatePicker = false
                                }

                            Button {
                                viewModel.showDatePicker = false
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 22))
                                    .foregroundColor(Color(UIColor.label).opacity(0.6))
                            }
                            .padding()
                            .vTop()
                            .hLeading()

                            // MARK: Disabling Past Dates
                            DatePicker(
                                "",
                                selection: $viewModel.taskDeadline,
                                in: Date.now...Date.distantFuture
                            )
                            .labelsHidden()
                            .datePickerStyle(.graphical)
                            .padding()
                            .background(Color(UIColor.systemBackground), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .padding()
                        }
                    }
                    .animation(.easeInOut, value: viewModel.showDatePicker)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onAppear {
            viewModel.setup()
        }
    }
}

struct AddNewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskView()
    }
}
