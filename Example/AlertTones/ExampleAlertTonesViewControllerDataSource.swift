//
//  ExampleAlertTonesViewControllerDataSource.swift
//  AlertTones
//
//  Created by Duncan Cunningham on 5/19/22.
//

import Foundation
import AlertTones

class ExampleAlertTonesViewControllerDataSource: AlertTonesViewControllerDataSource {
    
    private static let selectedAlertToneKey = "selectedAlertToneKey"
    
    // MARK: - AlertTonesViewControllerDataSource
    
    var selectedAlertTone: AlertTone? {
        guard
            let data = UserDefaults.standard.data(forKey: ExampleAlertTonesViewControllerDataSource.selectedAlertToneKey) else {
                return nil
        }
        
        let jsonDecoder = JSONDecoder()
        return try? jsonDecoder.decode(AlertTone.self, from: data)
    }
    
    func setSelectedAlertTone(alertTone: AlertTone) {
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(alertTone) else {
            return
        }
        
        UserDefaults.standard.setValue(data, forKey: ExampleAlertTonesViewControllerDataSource.selectedAlertToneKey)
    }
}
