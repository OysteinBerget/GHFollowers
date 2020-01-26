//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Øystein Berget on 26/01/2020.
//  Copyright © 2020 Øystein Berget. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    // MARK: - Properties
    static let resuseID = "FavoriteCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLable   = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    
    // MARK: - Initialize Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configuration Methods
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLable)
        
        accessoryType           = .disclosureIndicator
        let padding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLable.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLable.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func set(favorite: Follower) {
        usernameLable.text = favorite.login
        avatarImageView.downloadImage(from: favorite.avatarUrl)
    }
    
}
