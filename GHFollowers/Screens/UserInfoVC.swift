//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Øystein Berget on 13/01/2020.
//  Copyright © 2020 Øystein Berget. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    // MARK: - Properties
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let footerView  = GFBodyLabel(textAlignment: .center)
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
        
        itemViews = [headerView, itemViewOne, itemViewTwo, footerView]
        
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
            
            footerView.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            footerView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    
    func getUserInfo() {
        guard let username = username else { return }
        
        NetworkManager.shared.getUserInfo(for: username, completed: { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemVC(user: user), to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemVC(user: user), to: self.itemViewTwo)
                    self.setFotterView(with: user.createdAt)
                }
                print(user)
                
            case .failure(let error):
                self.presentGFAlertOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        })
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
    func setFotterView(with date: Date) {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MMMM YYYY"

        footerView.text = "GitHub since \(formatter.string(from: date))"
    }

    
    // MARK: - Navigation Methods
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}
