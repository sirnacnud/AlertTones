//
//  AlertTonesManager.swift
//  AlertTones
//
//  Created by Duncan Cunningham on 5/13/22.
//

import Foundation

public struct AlertTonesManager {
    
    private static let classicNamed = [
        "Alert": "/System/Library/Audio/UISounds/alarm.caf",
        "Bell": "/System/Library/Audio/UISounds/sms-received5.caf",
        "Chime": "/System/Library/Audio/UISounds/sms-received2.caf",
        "Ding": "/System/Library/Audio/UISounds/new-mail.caf",
        "Electronic": "/System/Library/Audio/UISounds/sms-received6.caf",
        "Glass": "/System/Library/Audio/UISounds/sms-received3.caf",
        "Horn": "/System/Library/Audio/UISounds/sms-received4.caf",
        "Swish": "/System/Library/Audio/UISounds/Swish.caf",
        "Swoosh": "/System/Library/Audio/UISounds/mail-sent.caf",
        "Tri-tone": "/System/Library/Audio/UISounds/sms-received1.caf",
        "Tweet": "/System/Library/Audio/UISounds/tweet_sent.caf"
    ]
    
    public func classicTones() -> [AlertTone] {
        var classicTones = self.fetchAlertTones(from: "/System/Library/Audio/UISounds/New")
        
        let fileManager = FileManager.default
        
        for (name, path) in Self.classicNamed {
            guard (fileManager.fileExists(atPath: path) == true) else {
                continue
            }
            
            classicTones.append(AlertTone(name: name, url: URL(fileURLWithPath: path)))
        }
        
        return classicTones.sorted(by: { $0.name < $1.name })
    }
    
    public func modernTones() -> [AlertTone] {
        let modernTones = self.fetchAlertTones(from: "/System/Library/PrivateFrameworks/ToneLibrary.framework/AlertTones/Modern")
        return modernTones.sorted(by: { $0.name < $1.name })
    }
    
    private func fetchAlertTones(from path: String) -> [AlertTone] {
        let baseUrl = URL(fileURLWithPath: path)
        guard let enumerator = FileManager.default.enumerator(at: baseUrl, includingPropertiesForKeys: [.isDirectoryKey, .nameKey], options: [.skipsHiddenFiles], errorHandler: nil) else {
            return []
        }

        var alertTones = [AlertTone]()
        
        while let fileUrl = enumerator.nextObject() as? URL {
            guard let alertTone = self.makeAlertTone(from: fileUrl) else {
                continue
            }
            
            alertTones.append(alertTone)
        }

        return alertTones
    }
    
    private func makeAlertTone(from url: URL) -> AlertTone? {
        guard
            let resourceValues = try? url.resourceValues(forKeys: [.nameKey, .isDirectoryKey]),
            (resourceValues.isDirectory == false),
            let name = resourceValues.name else {
                return nil
        }
        
        let nameWithoutExtension = String(name.dropLast(4))
        let nameWithoutUnderscore = nameWithoutExtension.replacingOccurrences(of: "_", with: " ")
        
        return AlertTone(name: nameWithoutUnderscore, url: url)
    }
}
