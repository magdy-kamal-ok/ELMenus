//
//  TagItemCollectionViewCell.swift
//  ElMenus
//
//  Created by mac on 7/19/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class TagItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagNameLbl: UILabel!
    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var containerTitleView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(tagModel: TagModel)
    {
        self.tagNameLbl.text = tagModel.tagName
        GlobalUtilities.downloadImage(path: tagModel.photoURL, placeholder: nil, into: self.tagImageView, indicator: nil)
        
        DispatchQueue.main.async {
            self.containerTitleView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        }
        
    }
    
}
