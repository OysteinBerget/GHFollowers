//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Øystein Berget on 13/01/2020.
//  Copyright © 2020 Øystein Berget. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGitHubProfile()
    func didTapGetFollowers()
}


class UserInfoVC: UIViewController {
    
    // MARK: - Properties
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel  = GFBodyLabel(textAlignment: .center)
    var itemViews   = [UIView]()
    
    var username: String!
    

    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    
    // MARK: - Configuration Methods
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func layoutUI() {
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    
    
    func getUserInfo() {
        guard let username = username else { return }
        
        NetworkManager.shared.getUserInfo(for: username, completed: { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                print(user)
                
            case .failure(let error):
                self.presentGFAlertOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        })
    }
    
    
    func configureUIElements(with user: User) {
        let repoItemVC          = GFRepoItemVC(user: user)
        repoItemVC.delegate     = self
        
        let followerItemVC      = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.setDateLabel(withDate: user.createdAt)
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
    func setDateLabel(withDate date: Date) {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MMMM YYYY"

        dateLabel.text = "GitHub since \(formatter.string(from: date))"
    }

    
    // MARK: - Navigation Methods
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}

// MARK: - Extensions
extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile() {
        // Show safari view controller
        print("GitHub Profile tapped")
    }
    
    func didTapGetFollowers() {
        // Dismiss VC
        // tell Followers list screen the new user
        print("Get Followers tapped")
    }
    
    
}
