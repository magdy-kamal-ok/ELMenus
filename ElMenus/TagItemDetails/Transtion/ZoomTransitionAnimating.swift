//
//  ZoomTransitionAnimating.swift
//  ElMenus
//
//  Created by mac on 7/22/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

public protocol ZoomTransitionAnimating: class {
    var transitionSourceImageView: UIImageView { get }
    var transitionSourceBackgroundColor: UIColor? { get }
    var transitionDestinationImageViewFrame: CGRect { get }
}

@objc public protocol ZoomTransitionDelegate: class {
    @objc optional func zoomTransitionAnimator(animator: ZoomTransitionAnimator,
                                               didCompleteTransition didComplete: Bool,
                                               animatingSourceImageView imageView: UIImageView)
}
