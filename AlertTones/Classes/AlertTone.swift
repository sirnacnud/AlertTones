//
//  AlertTone.swift
//  AlertTones
//
//  Created by Duncan Cunningham on 5/13/22.
//

import Foundation

public final class AlertTone: NSObject, Codable {
    
    @objc
    public let name: String
    
    @objc
    public let url: URL
    
    @objc
    public init(name: String, url: URL) {
        self.name = name
        self.url = url
        
        super.init()
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let alertTone = object as? AlertTone else {
            return false
        }
        
        return (self.name == alertTone.name && self.url == alertTone.url)
    }
}
