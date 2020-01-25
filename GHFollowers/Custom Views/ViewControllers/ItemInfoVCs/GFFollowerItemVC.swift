//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Øystein Berget on 25/01/2020.
//  Copyright © 2020 Øystein Berget. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    // Mark: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }
    
    
    // MARK: - Configuration Methods
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .following, withCount: user.following)
        itemInfoViewTwo.set(itemInfoType: .followers, withCount: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
//        
//        if user.followers == 0 {
//            actionButton.isEnabled = false
//        }
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
