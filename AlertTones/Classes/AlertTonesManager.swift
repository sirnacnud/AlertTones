//
//  AlertTonesManager.swift
//  AlertTones
//
//  Created by Duncan Cunningham on 5/13/22.
//

import Foundation

public class AlertTonesManager {
    
    private lazy var systemLibraryPath: String = {
        #if targetEnvironment(simulator)
            let xcodePath = (ProcessInfo.processInfo.environment["XCODE-PATH"] ?? "")
            return "\(xcodePath)/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library"
        #else
            return "/System/Library"
        #endif
    }()
    
    private lazy var classicNamed = [
        "Alert".localized: "\(self.systemLibraryPath)/Audio/UISounds/alarm.caf",
        "Bell".localized: "\(self.systemLibraryPath)/Audio/UISounds/sms-received5.caf",
        "Chime".localized: "\(self.systemLibraryPath)/Audio/UISounds/sms-received2.caf",
        "Ding".localized: "\(self.systemLibraryPath)/Audio/UISounds/new-mail.caf",
        "Electronic".localized: "\(self.systemLibraryPath)/Audio/UISounds/sms-received6.caf",
        "Glass".localized: "\(self.systemLibraryPath)/Audio/UISounds/sms-received3.caf",
        "Horn".localized: "\(self.systemLibraryPath)/Audio/UISounds/sms-received4.caf",
        "Swish".localized: "\(self.systemLibraryPath)/Audio/UISounds/Swish.caf",
        "Swoosh".localized: "\(self.systemLibraryPath)/Audio/UISounds/mail-sent.caf",
        "Tri-tone".localized: "\(self.systemLibraryPath)/Audio/UISounds/sms-received1.caf",
        "Tweet".localized: "\(self.systemLibraryPath)/Audio/UISounds/tweet_sent.caf"
    ]
    
    public func classicTones() -> [AlertTone] {
        var classicTones = self.fetchAlertTones(from: "\(self.systemLibraryPath)/Audio/UISounds/New")
        
        let fileManager = FileManager.default
        
        for (name, path) in self.classicNamed {
            guard (fileManager.fileExists(atPath: path) == true) else {
                continue
            }
            
            classicTones.append(AlertTone(name: name, url: URL(fileURLWithPath: path)))
        }
        
        return classicTones.sorted(by: { $0.name < $1.name })
    }
    
    public func modernTones() -> [AlertTone] {
        let modernTones = self.fetchAlertTones(from: "\(self.systemLibraryPath)/PrivateFrameworks/ToneLibrary.framework/AlertTones/Modern")
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
        
        return AlertTone(name: nameWithoutUnderscore.localized, url: url)
    }
}
