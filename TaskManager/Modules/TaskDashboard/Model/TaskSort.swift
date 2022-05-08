//
//  TaskSort.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 8.05.2022.
//

import Foundation

enum TaskSort {

    static func getSortDescriptors(with currentTab: CustomSegmentedBarType) -> [NSSortDescriptor] {
        switch currentTab {
        case .today:
            return [.init(keyPath: \Task.deadline, ascending: true)]
        case .upcoming:
            return [.init(keyPath: \Task.deadline, ascending: true)]
        case .done:
            return [.init(keyPath: \Task.deadline, ascending: false)]
        case .failed:
            return [.init(keyPath: \Task.deadline, ascending: false)]
        }
    }

    static func getPredicate(with currentTab: CustomSegmentedBarType) -> NSPredicate? {
        // MARK: Predicate to Filter current date Tasks
        let calendar = Calendar.current

        switch currentTab {
        case .today:
            let today = calendar.startOfDay(for: Date())
            let tommorow = calendar.date(byAdding: .day, value: 1, to: today)!

            // Filter Key
            let filterKey = "deadline"

            // This will fetch task between today and tommorow which is 24 HRS
            // 0-false, 1-true
            return NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [today,tommorow,0])

        case .upcoming:
            let today = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: Date())!)
            let tommorow = Date.distantFuture

            // Filter Key
            let filterKey = "deadline"

            // This will fetch task between today and tommorow which is 24 HRS
            // 0-false, 1-true
            return NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [today,tommorow,0])

        case .done:
            // 0-false, 1-true
            return NSPredicate(format: "isCompleted == %i", argumentArray: [1])

        case .failed:
            let today = calendar.startOfDay(for: Date())
            let past = Date.distantPast

            // Filter Key
            let filterKey = "deadline"

            // This will fetch task between today and tommorow which is 24 HRS
            // 0-false, 1-true
            return NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [past,today,0])
        }
    }
}
