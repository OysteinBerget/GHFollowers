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
    let tableView = UITableView()
    var favorites = [Follower]()

    // MARK: - LifeCyle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        getFavorites()
    }
    
    
    // MARK: - Configuration Methods
    private func configureViewController() {
        view.backgroundColor    = .systemBackground
        title                   = "Favorites"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen.", in: view)
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.resuseID)
    }
    
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.tableView.isHidden = true
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

}

// MARK: - Extensions
extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.resuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC()
        destVC.username = favorite.login
        destVC.title    = favorite.login
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        if favorites.isEmpty {
            tableView.isHidden = true
        }
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] (error) in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
}
