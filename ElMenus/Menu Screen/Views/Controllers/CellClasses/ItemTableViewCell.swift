//
//  ItemTableViewCell.swift
//  ElMenus
//
//  Created by mac on 7/20/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var containerTitleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }
    
    func configureCell(itemModel: ItemModel)
    {
        self.itemNameLbl.text = itemModel.name
        GlobalUtilities.downloadImage(path: itemModel.photoUrl, placeholder: nil, into: self.itemImageView, indicator: nil)
        
        DispatchQueue.main.async {
            self.itemImageView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
            self.containerTitleView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        }
        
    }
}
