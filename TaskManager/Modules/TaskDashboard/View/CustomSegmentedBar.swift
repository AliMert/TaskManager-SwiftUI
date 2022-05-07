//
//  CustomSegmentedBar.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import SwiftUI

protocol CustomSegmentedBarProtocol: ObservableObject {
    var currentTab: CustomSegmentedBarItem { get set }
    var tabs: [CustomSegmentedBarItem] { get }
}

struct CustomSegmentedBarItem: Identifiable, Equatable {
    let id = UUID().uuidString
    let title: String

    init(_ title: String) {
        self.title = title
    }
}

struct CustomSegmentedBar<Observable>: View where Observable: CustomSegmentedBarProtocol {

    @ObservedObject var delegate: Observable
    var animation: Namespace.ID

    var body: some View {
        HStack(spacing: 10) {
            ForEach(delegate.tabs, id: \.id) { tab in
                let isCurrentTab = delegate.currentTab == tab
                if isCurrentTab {
                    Text(tab.title)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .scaleEffect(0.9)
                        .background {
                            Capsule()
                                .fill(Color("CustomSegmentedBarBackground"))
                                .matchedGeometryEffect(id: String(describing: CustomSegmentedBar.self), in: animation)
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                delegate.currentTab = tab
                            }
                        }
                        .shadow(color: .black, radius: 0.5, x: 0.8, y: 0.5)

                } else {
                    Text(tab.title)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("CustomSegmentedBarForeground"))
                        .lineLimit(1)
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .scaleEffect(0.9)
                        .background {
                            Capsule()
                                .fill(.clear)
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                delegate.currentTab = tab
                            }
                        }
                }

            }
        }
    }
}

struct CustomSegmentedBar_Previews: PreviewProvider {
    @Namespace static var animation: Namespace.ID

    static var previews: some View {
        CustomSegmentedBar(delegate: TaskDashboardViewModel(), animation: animation)
            .preferredColorScheme(.dark)
    }
}
