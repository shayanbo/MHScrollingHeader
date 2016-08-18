//
//  MineViewController.swift
//  MHScrollingHeader
//
//  Created by shayanbo on 16/8/18.
//  Copyright © 2016年 mx. All rights reserved.
//

import Foundation
import UIKit

class MineViewController: UIViewController {

    private lazy var headContainer = UIView()
    private lazy var beltBar = BeltBar(frame: CGRect())
    private lazy var profileView = ProfileView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupNavigationBar()
        setupUI()
    }

    private func setupNavigationBar() {

        self.navigationItem.title = "MickeySha"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "bar-button-settings"),
            style: .Plain,
            target: self,
            action: #selector(settings))
    }
    
    private func setupUI() {
        
        
    }
}

// MARK: - Action
extension MineViewController {

    @objc private func settings() {

    }
}
