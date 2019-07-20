//
//  MenuViewController.swift
//  ElMenus
//
//  Created by mac on 7/19/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

class MenuViewController: BaseMenuViewController {
    
    let disposeBag = DisposeBag()
    let tagsViewModel = TagsViewModel()
    private var tagsList = [TagModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listenToTagsList()
        tagsViewModel.getTagsList()

    }
    
    override func setupCellNibNames()
    {
        self.menuTableView.registerCellNib(cellClass: TagTableViewCell.self)
    }
    
    func listenToTagsList()
    {
        tagsViewModel.observableTagList.subscribe(onNext: { (tagsList) in
            self.tagsList = tagsList
            self.menuTableView.reloadData()
            
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
    }
    
    override func getCellsCount(with section: Int) -> Int {
        return 1
    }
    override func getSectionsCount() -> Int {
        return 1
    }
    override func getCellHeight() -> CGFloat {
        return 250
    }
    
    override func getCustomCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as TagTableViewCell
        cell.configureCell(tagsList: self.tagsList)
        return cell
    }
}
