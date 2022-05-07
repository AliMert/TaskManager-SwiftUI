//
//  ContentView.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    init() {
        let image = UIImage(systemName: "arrow.left")
        UINavigationBar.appearance().backIndicatorImage = image
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        UINavigationBar.appearance().tintColor = .label
    }
    
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

