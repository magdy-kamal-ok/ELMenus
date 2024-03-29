//
//  BaseViewModel.swift
//  ElMenus
//
//  Created by mac on 7/21/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit
import Reachability

class BaseNetworkConnectionViewModel: NSObject {

    let reachability = Reachability()!

    override init() {
        super.init()
        do {
            try self.reachability.startNotifier()
        } catch {

        }
        self.checkIfNoConnection()
        self.checkIfConnection()
    }

    private func checkIfConnection() {
        self.reachability.whenReachable = { _ in
            self.handleInternetConnectionReconnected()
        }
    }
    private func checkIfNoConnection() {
        self.reachability.whenUnreachable = { _ in
            self.handleInternetConnectionDisconnected()
        }
    }

    func isNetworkConnected() -> Bool {
        return self.reachability.connection != .none
    }

    func handleInternetConnectionDisconnected()
    {
        // override this function in extended class
    }
    func handleInternetConnectionReconnected()
    {
        // override this function in extended class
    }

    public func showProgressLoaderIndicator() {
        DispatchQueue.main.async {
            UIHelper.showProgressBarWithDimView()
        }

    }


    public func hideProgressLoaderIndicator() {
        DispatchQueue.main.async {
            UIHelper.dissmissProgressBar()
        }

    }
}
