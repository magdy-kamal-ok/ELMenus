//
//  TagItemViewController.swift
//  ElMenus
//
//  Created by mac on 7/21/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class TagItemViewController: UIViewController {

    @IBOutlet weak var itemDescriptionLbl: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    let navBarHeight: CGFloat = 66.0
    var itemDescription:String = ""
    var itemName:String = "" 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftNavbarBackButton()
        self.navigationController?.navigationBar.setAttributedTitle()
        self.scrollView.delegate = self
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
    }
    func addLeftNavbarBackButton()
    {
        
        let backBarButton = UIBarButtonItem.init(image: UIImage.init(named: Constants.backButtonImage), style: .plain, target: self, action: #selector(backButtonClick))
        backBarButton.tintColor = .white
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    @objc func backButtonClick()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension TagItemViewController:UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
  
        
        if scrollView.contentOffset.y > (self.itemImageView.frame.height - (1.5 * navBarHeight)) && self.navigationController?.navigationBar.backgroundImage(for: UIBarMetrics.default) == nil
        {
        self.navigationController?.navigationBar.setBackgroundImage(self.itemImageView.image, for: UIBarMetrics.default)
            
            self.navigationController?.navigationBar.shadowImage = nil
            
        }
        else if scrollView.contentOffset.y < (self.itemImageView.frame.height - (1.5 * navBarHeight)) && self.navigationController?.navigationBar.backgroundImage(for: UIBarMetrics.default) != nil
        {
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
        }

    
    }
}
extension TagItemViewController: ZoomTransitionAnimating {
    var transitionSourceImageView: UIImageView {
        let imageView = UIImageView(image: self.itemImageView.image)
        imageView.contentMode = self.itemImageView.contentMode
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.frame = self.itemImageView.frame
        return imageView;
    }
    
    var transitionSourceBackgroundColor: UIColor? {
        return view.backgroundColor
    }
    
    var transitionDestinationImageViewFrame: CGRect {
        let width = self.view.frame.width
        var frame = self.itemImageView.frame
        frame.size.width = width
        return frame
    }
}

extension TagItemViewController: ZoomTransitionDelegate {
    func zoomTransitionAnimator(animator: ZoomTransitionAnimator,
                                didCompleteTransition didComplete: Bool,
                                animatingSourceImageView imageView: UIImageView) {
        self.itemImageView.image = imageView.image
        self.itemDescriptionLbl.text = self.itemDescription
        self.title = self.itemName
        
    }
}
