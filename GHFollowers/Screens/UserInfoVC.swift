//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Øystein Berget on 13/01/2020.
//  Copyright © 2020 Øystein Berget. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        guard let username = username else { return }
        title = username
        
        NetworkManager.shared.getUserInfo(for: username, completed: { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.user = user
                print(user)
                
            case .failure(let error):
                self.presentGFAlertOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        })
        
    }
    

    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}
