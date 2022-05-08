//
//  CustomSegmentedBarType.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 8.05.2022.
//

import Foundation

enum CustomSegmentedBarType: String, CaseIterable {
    case today = "Today"
    case upcoming = "Upcoming"
    case done = "Done"
    case failed = "Failed"

    init?(item: CustomSegmentedBarItem) {
        switch item.title {
        case CustomSegmentedBarType.today.rawValue:
            self = .today
        case CustomSegmentedBarType.upcoming.rawValue:
            self = .upcoming
        case CustomSegmentedBarType.done.rawValue:
            self = .done
        case CustomSegmentedBarType.failed.rawValue:
            self = .failed
        default:
            return nil
        }
    }
}
