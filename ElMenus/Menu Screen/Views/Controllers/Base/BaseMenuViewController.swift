//
//  BaseMenuViewController.swift
//  ElMenus
//
//  Created by mac on 7/20/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//
import UIKit

class BaseMenuViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var menuTableView: UITableView!

    
    // MARK: - Base Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableDataSource()
        setupCellNibNames()
        setNavTitle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    func setNavTitle()
    {
        let logo = UIImage(named: "ic-marvel")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }

    
    
    // MARK: - Table view
    
    func setupTableDataSource() -> Void {
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
    }
    
    
    // MARK: Table view nib name
    
    public func setupCellNibNames() -> Void {
        // This methode will overridw at sub classes
    }
    
    
    func getCellHeight() -> CGFloat {
        preconditionFailure("You have to Override getCellHeight Function first to be able to set cell height")
    }
    
    func getCellsCount(with section:Int)->Int
    {
        preconditionFailure("You have to Override getCellsCount Function first to be able to set number of cells count")
    }
    
    func getSectionsCount()->Int
    {
        preconditionFailure("You have to Override getSectionsCount Function first to be able to set number of sections count")
    }
    
    
    // MARK: - Loading Progress
    // MARK: Show
    
    public func showProgressLoaderIndicator(){
        DispatchQueue.main.async {
            UIHelper.showProgressBarWithDimView()
        }
        
    }
    
    
    // MARK: Hide
    
    public func hideProgressLoaderIndicator(){
        DispatchQueue.main.async {
            UIHelper.dissmissProgressBar()
        }
        
    }
    
    
}


// MARK: - UITableViewDataSource

extension BaseMenuViewController : UITableViewDataSource{
    
    
    // MARK: Height for cell
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getCellHeight()
    }
    
    // MARK: Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.getSectionsCount()
    }
    
    // MARK: Number of rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getCellsCount(with:section)
    }
    
    
    // MARK: Cell for row
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return getCustomCell(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCellAt(indexPath: indexPath)
    }
    
    @objc func getCustomCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell.init()
    }
    
    @objc func didSelectCellAt(indexPath: IndexPath)  {
        
        
    }
}

extension BaseMenuViewController: UITableViewDelegate {
    
}
