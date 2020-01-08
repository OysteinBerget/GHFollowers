//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Øystein Berget on 08/01/2020.
//  Copyright © 2020 Øystein Berget. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        
    }
    


    // MARK: - Navigation

    

}
