//
//  TagTableViewCell.swift
//  ElMenus
//
//  Created by mac on 7/19/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    private var tagsList = [TagModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tagsCollectionView.delegate = self
        self.tagsCollectionView.dataSource = self
        self.tagsCollectionView.register(UINib.init(nibName: "TagItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagItemCollectionViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(tagsList:[TagModel])
    {
        self.tagsList = tagsList
        self.tagsCollectionView.reloadData()
    }
    
}

extension TagTableViewCell:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tagsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagItemCollectionViewCell", for: indexPath) as! TagItemCollectionViewCell
        cell.configureCell(tagModel: self.tagsList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 150, height: self.tagsCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let inset = scrollView.contentInset
        let y: CGFloat = offset.x - inset.left
        let reload_distance: CGFloat = -15
        if y < reload_distance{
            scrollView.bounces = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.tagsCollectionView.bounces = true
            }
            print("refresh")
        }
    }
}

