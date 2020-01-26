//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Øystein Berget on 08/01/2020.
//  Copyright © 2020 Øystein Berget. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    // MARK: - Properies
    var username: String!

    // MARK: - LifeCyle Method
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        PersistenceManager.retrieveFavorites { (result) in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - Configuration Methods
    
    // MARK: - Navigation

    

}
