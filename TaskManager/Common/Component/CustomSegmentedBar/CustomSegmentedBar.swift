//
//  CustomSegmentedBar.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import SwiftUI

//  MARK: - CustomSegmentedBar Protocol
protocol CustomSegmentedBarProtocol: ObservableObject {
    var currentTab: CustomSegmentedBarItem { get set }
    var tabs: [CustomSegmentedBarItem] { get }
}


//  MARK: - CustomSegmentedBar

struct CustomSegmentedBar<Observable>: View where Observable: CustomSegmentedBarProtocol {

    @ObservedObject var delegate: Observable
    var animation: Namespace.ID

    var body: some View {
        HStack(spacing: 10) {
            ForEach(delegate.tabs) { tab in
                let isCurrentTab = delegate.currentTab.id == tab.id
                if isCurrentTab {
                    Text(tab.title)
                        .font(.body)
                        .fontWeight(.semibold)
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
