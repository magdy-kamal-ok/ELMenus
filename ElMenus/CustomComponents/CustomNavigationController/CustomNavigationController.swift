//
//  File.swift
//  ElMenus
//
//  Created by mac on 7/22/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//
import UIKit

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let sourceTransition = fromVC as? ZoomTransitionAnimating,
            let destinationTransition = toVC as? ZoomTransitionable else {
                return nil
        }
        
        let animator = ZoomTransitionAnimator()
        animator.goingForward = (operation == .push)
        animator.sourceTransition = sourceTransition
        animator.destinationTransition = destinationTransition
        return animator;
    }
}
