//
//  BeltBar.swift
//  MHScrollingHeader
//
//  Created by shayanbo on 16/8/18.
//  Copyright © 2016年 mx. All rights reserved.
//

import Foundation
import UIKit

class BeltBar: UIToolbar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        items = [
            UIBarButtonItem(
                image: UIImage(named:"profile-grid"),
                style: .Plain,
                target: self,
                action: #selector(profileGridItemDidClick)),
            UIBarButtonItem(
                image: UIImage(named:"profile-list"),
                style: .Plain,
                target: self,
                action: #selector(profileListItemDidClick)),
            UIBarButtonItem(
                image: UIImage(named:"location"),
                style: .Plain,
                target: self,
                action: #selector(locationItemDidClick)),
            UIBarButtonItem(
                image: UIImage(named:"profile-usertags"),
                style: .Plain,
                target: self,
                action: #selector(profileUsertagsItemDidClick)),
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Action
extension BeltBar {
    
    func profileGridItemDidClick() {
        
    }
    
    func profileListItemDidClick() {
        
    }
    
    func locationItemDidClick() {
        
    }
    
    func profileUsertagsItemDidClick() {
        
    }
}