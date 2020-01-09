//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Øystein Berget on 09/01/2020.
//  Copyright © 2020 Øystein Berget. All rights reserved.
//

import Foundation

enum ErrorMessage: String {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}
