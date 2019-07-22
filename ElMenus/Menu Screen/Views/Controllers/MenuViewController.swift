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

enum SectionType {
    case tagsSection(String)
    case tagsItemsSection(String)
}
extension SectionType
{
    var sectionTitle:String{
        switch self {
        case .tagsSection(let tags):
            return tags
        case .tagsItemsSection(let tagName):
            return tagName
        }
    }
}
class MenuViewController: BaseMenuViewController {
    
    let disposeBag = DisposeBag()
    let tagsViewModel = TagsViewModel()
    let itemsTagViewModel = ItemsTagViewModel()
    private var tagsList = [TagModel]()
    private var itemsTagModel:ItemsResponseModel?
    var menuSections = [SectionType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwipeRefresh()
        listenToTagsList()
        listenToTagItems()
        tagsViewModel.getTagsList()

    }
    
    override func setupCellNibNames()
    {
        self.menuTableView.registerCellNib(cellClass: TagTableViewCell.self)
        self.menuTableView.registerCellNib(cellClass: ItemTableViewCell.self)
        
    }
    
    func listenToTagsList()
    {
        itemsTagViewModel.observableTagItem.subscribe(onNext: { (itemsTagModel) in
            self.itemsTagModel = itemsTagModel
            self.checkRefreshControlState()
            self.setTableViewDataSource()
            
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
    }
    
    func listenToTagItems()
    {
        tagsViewModel.observableTagList.subscribe(onNext: { (tagsList) in
            self.tagsList = tagsList
            self.setTableViewDataSource()
            
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
    }
    
    func setTableViewDataSource()
    {
        
        self.menuSections.removeAll()
        if self.tagsList.count != 0
        {
            self.menuSections.append(.tagsSection("Tags"))
        }
        if let itemsTagModel = self.itemsTagModel
        {
            if itemsTagModel.items.toArray().count != 0
            {
                self.menuSections.append(.tagsItemsSection(itemsTagModel.tagName))
            }
        }
        self.menuTableView.reloadData()
    }
    
    override func swipeRefreshTableView() {
        self.tagsViewModel.refreshTagsList()
        self.itemsTagViewModel.refreshTagItemsList()
    }

    override func getCellsCount(with section: Int) -> Int {
        
        let sectionType = self.menuSections[section]
        switch sectionType {
        case .tagsSection:
            return 1
        case .tagsItemsSection:
            return self.itemsTagModel!.items.toArray().count
        }
    }
    
    override func getSectionsCount() -> Int {
        return self.menuSections.count
    }
    
    override func getCellHeight(indexPath:IndexPath) -> CGFloat {
        let sectionType = self.menuSections[indexPath.section]
        switch sectionType {
        case .tagsSection:
            return 250
        case .tagsItemsSection:
            return 220
        }
    }
    
    override func getCustomCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = self.menuSections[indexPath.section]
        switch sectionType {
            case .tagsSection:
                let cell = tableView.dequeue() as TagTableViewCell
                cell.configureCell(tagsList: self.tagsList)
                cell.tagTableViewCellDelegate = self
                return cell
            case .tagsItemsSection:
                let cell = tableView.dequeue() as ItemTableViewCell
                if let itemsTagModel = self.itemsTagModel
                {
                   cell.configureCell(itemModel: itemsTagModel.items.toArray()[indexPath.row])
                }
                return cell
        }
    }
    override func didSelectCellAt(indexPath: IndexPath) {
        
        let sectionType = self.menuSections[indexPath.section]
        
        switch sectionType {
            case .tagsItemsSection:
                if let itemsTagModel = self.itemsTagModel
                {
                    self.openTagItemDetails(itemModel: itemsTagModel.items.toArray()[indexPath.row])
                }
            default:
            print("")
        }
    }
    override func setupCustomHeaderView(section : Int) -> UIView?{
        
        let view = UIView(frame: .zero)
        let textLabel = UILabel()
        textLabel.textColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        view.addSubview(textLabel)
        view.backgroundColor = UIColor(named:"BasicColor")

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let sectionType = self.menuSections[section]
        textLabel.text = sectionType.sectionTitle
        return view
        
    }
    func openTagItemDetails(itemModel:ItemModel)
    {
        let tagItemViewController = TagItemViewController.init(nibName: "TagItemViewController", bundle: nil)
        tagItemViewController.itemDescription = itemModel.desc
        tagItemViewController.itemName = itemModel.name
        self.navigationController?.pushViewController(tagItemViewController, animated: true)
    }
}

extension MenuViewController: TagTableViewCellDelegate{
    func didSelectCell(tagModel: TagModel) {
        self.itemsTagViewModel.getTagsList(tagName: tagModel.tagName)
    }
    
    func loadMoreTags() {
        self.tagsViewModel.loadMoreTags()
    }
    
    
}

extension MenuViewController: ZoomTransitionAnimating, ZoomTransitionDelegate {
    var transitionSourceImageView: UIImageView {
        let selectedIndexPath = self.menuTableView.indexPathForSelectedRow!
        let sectionType = self.menuSections[selectedIndexPath.section]
        switch sectionType {
            case .tagsItemsSection:
                let cell = self.menuTableView.cellForRow(at: selectedIndexPath) as! ItemTableViewCell
                let imageView = UIImageView(image: cell.itemImageView.image)
                imageView.contentMode = cell.itemImageView.contentMode;
                imageView.clipsToBounds = true
                imageView.isUserInteractionEnabled = false
                var frameInSuperview = cell.itemImageView.convert(cell.itemImageView.frame, to: self.menuTableView.superview)
                frameInSuperview.origin.x -= 8 // Left margin of ImageView from Cell
                frameInSuperview.origin.y -= 8 // Top margin of ImageView from Cell
                imageView.frame = frameInSuperview
                return imageView
            
            case .tagsSection:
                    return UIImageView.init()
        }
    }
    
    var transitionSourceBackgroundColor: UIColor? {
        return self.menuTableView.backgroundColor
    }
    
    var transitionDestinationImageViewFrame: CGRect {
        let selectedIndexPath = self.menuTableView.indexPathForSelectedRow!
        let sectionType = self.menuSections[selectedIndexPath.section]
        switch sectionType {
            case .tagsItemsSection:
                let cell = self.menuTableView.cellForRow(at: selectedIndexPath) as! ItemTableViewCell
                var frameInSuperview = cell.itemImageView.convert(cell.itemImageView.frame, to: self.menuTableView.superview)
                frameInSuperview.origin.x -= 8 // Left margin of ImageView from Cell
                frameInSuperview.origin.y -= 8 // Top margin of ImageView from Cell
                return frameInSuperview
            case .tagsSection:
                return CGRect.zero
        }
    }
}
