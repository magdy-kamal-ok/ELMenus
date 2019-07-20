//
//  MenuViewController.swift
//  ElMenus
//
//  Created by mac on 7/19/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit
import RealmSwift

class MenuViewController: BaseMenuViewController {
    
    let tagRepo = TagsRepository.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        tagRepo.getTagsList(offset: 1)
    }
    
    override func setupCellNibNames()
    {
        self.menuTableView.registerCellNib(cellClass: TagTableViewCell.self)
    }
    
    override func getCellsCount(with section: Int) -> Int {
        return 2
    }
    override func getSectionsCount() -> Int {
        return 1
    }
    override func getCellHeight() -> CGFloat {
        return 200
    }
    
    override func getCustomCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as TagTableViewCell
        return cell
    }
}
