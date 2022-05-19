//
//  String+Localized.swift
//  AlertTones
//
//  Created by Duncan Cunningham on 5/19/22.
//

import Foundation

extension String {
    
    private static let resourceBundle: Bundle? = {
        let podBundle = Bundle(for: AlertTonesManager.self)
        
        guard let resourceBundleURL = podBundle.url(forResource: "AlertTones", withExtension: "bundle") else {
            return nil
        }
        
        return Bundle(url: resourceBundleURL)
    }()
    
    internal var localized: String {
        guard let resourceBundle = Self.resourceBundle else {
            return ""
        }
        
        return NSLocalizedString(self, tableName: nil, bundle: resourceBundle, value: self, comment: "")
    }
}
