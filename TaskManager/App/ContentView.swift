//
//  ContentView.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        NavigationView {
            TaskDashboardView(viewModel: .init())
                .navigationTitle("Task Manager")
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
