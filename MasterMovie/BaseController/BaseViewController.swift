//
//  BaseViewController.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
   let loadingViewController = LoadingViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @MainActor
    func showProgress() {
        loadingViewController.view.frame = UIApplication.shared.keyWindow?.bounds ?? UIScreen.main.bounds
        let window = self.view.window
        let subViews = window?.subviews ?? []
        if !subViews.contains(loadingViewController.view) {
            window?.addSubview(loadingViewController.view)
        }
        UIApplication.shared.keyWindow?.bringSubviewToFront(loadingViewController.view)
    }

    @MainActor
    func hideProgress() {
        loadingViewController.view.removeFromSuperview()
    }
}
