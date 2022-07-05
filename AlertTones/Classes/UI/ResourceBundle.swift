//
//  ResourceBundle.swift
//  AlertTones
//
//  Created by Duncan Cunningham on 6/17/22.
//

import Foundation

internal enum ResourceBundle {
    
    internal static let instance: Bundle? = {
        let podBundle = Bundle(for: AlertTonesManager.self)
        
        guard let resourceBundleURL = podBundle.url(forResource: "AlertTones", withExtension: "bundle") else {
            return nil
        }
        
        return Bundle(url: resourceBundleURL)
    }()
}
