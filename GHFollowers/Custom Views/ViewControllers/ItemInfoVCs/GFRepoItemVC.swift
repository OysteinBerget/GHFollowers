//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Øystein Berget on 25/01/2020.
//  Copyright © 2020 Øystein Berget. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    // Mark: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }
    
    
    // MARK: - Configuration Methods
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
        
        if user.followers == 0 {
            actionButton.isEnabled = false
        }
    }
}
