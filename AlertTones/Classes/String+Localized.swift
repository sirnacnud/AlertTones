//
//  String+Localized.swift
//  AlertTones
//
//  Created by Duncan Cunningham on 5/19/22.
//

import Foundation

extension String {

    internal var localized: String {
        guard let resourceBundle = ResourceBundle.instance else {
            return ""
        }
        
        return NSLocalizedString(self, tableName: nil, bundle: resourceBundle, value: self, comment: "")
    }
}
