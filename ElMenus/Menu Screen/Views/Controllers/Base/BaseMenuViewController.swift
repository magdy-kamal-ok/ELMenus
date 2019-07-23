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

    private var refreshControl: UIRefreshControl?
    
    // MARK: - Base Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessibleIdentifiers()
        setupTableDataSource()
        setupCellNibNames()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    public func setAccessibleIdentifiers()
    {
        self.menuTableView.accessibilityIdentifier = Constants.tableViewIdentifier
    }
    func getCellHeight(indexPath:IndexPath) -> CGFloat {
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
    
    
    // MARK: Refresh cotrol
    func setupSwipeRefresh() -> Void {
        refreshControl = UIRefreshControl()
        
        refreshControl?.tintColor = UIColor(named:Constants.basicColor)
        refreshControl?.addTarget(self, action: #selector(swipeRefreshTableView), for: .valueChanged)
        self.menuTableView.addSubview(refreshControl!)
    }
    
    @objc func swipeRefreshTableView() {
        // override this when you need to refresh table data by swipe
    }
    
    func endRefreshTableView() -> Void {
        self.refreshControl?.endRefreshing()
    }
    
    func checkRefreshControlState() -> Void {
        DispatchQueue.main.async {
            if (self.refreshControl?.isRefreshing)! {
                self.refreshControl?.endRefreshing()
            }
        }
    }
}


// MARK: - UITableViewDataSource

extension BaseMenuViewController : UITableViewDataSource{
    
    
    // MARK: Height for cell
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getCellHeight(indexPath:indexPath)
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setupCustomHeaderView(section: section)
    }
        
    @objc func getCustomCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell.init()
    }
    
    @objc func didSelectCellAt(indexPath: IndexPath)  {
        
    }
    
    @objc func setupCustomHeaderView(section : Int) -> UIView?
    {
        return nil
    }
}

extension BaseMenuViewController: UITableViewDelegate {
    
}
