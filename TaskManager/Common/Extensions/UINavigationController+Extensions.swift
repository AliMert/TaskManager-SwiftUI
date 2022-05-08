//
//  UINavigationController+Extensions.swift
//  TaskManager
//
//  Created by Ali Mert Özhayta on 7.05.2022.
//

import UIKit.UINavigationController

// MARK: Makes Swipe Back Gesture works when Navigation Bar is hidden

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
