//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Øystein Berget on 25/01/2020.
//  Copyright © 2020 Øystein Berget. All rights reserved.
//

import Foundation


extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
