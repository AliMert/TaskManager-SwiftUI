//
//  CustomSegmentedBar.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import SwiftUI

protocol CustomSegmentedBarProtocol: ObservableObject {
    var currentTab: String { get set }
    var tabs: [String] { get }
}

struct CustomSegmentedBar<Observable>: View where Observable: CustomSegmentedBarProtocol {

    @ObservedObject var delegate: Observable
    var animation: Namespace.ID

    var body: some View {
        HStack(spacing: 10) {
            ForEach(delegate.tabs, id: \.self) { tab in
                Text(tab)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(delegate.currentTab == tab ? .white : .black)
                    .scaleEffect(0.9)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .background {
                        if delegate.currentTab == tab {
                            Capsule().fill(.black)
                                .matchedGeometryEffect(id: String(describing: CustomSegmentedBar.self), in: animation)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            delegate.currentTab = tab
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
    }
}
