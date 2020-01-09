//
//  Follower.swift
//  GHFollowers
//
//  Created by Øystein Berget on 09/01/2020.
//  Copyright © 2020 Øystein Berget. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}
