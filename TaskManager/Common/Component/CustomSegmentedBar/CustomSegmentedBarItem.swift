//
//  CustomSegmentedBarItem.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import Foundation

struct CustomSegmentedBarItem: Identifiable, Equatable {
    let id = UUID().uuidString
    let title: String

    init(_ title: String) {
        self.title = title
    }
}
