//
//  String.swift
//  EnergiseTest
//
//  Created by Evgeniy Zelinskiy on 25.04.2024.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
