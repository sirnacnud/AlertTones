//
//  AlertTonesPickerController.swift
//  AlertTones
//
//  Created by Duncan Cunningham on 5/19/22.
//

import Foundation
import UIKit

public class AlertTonesPickerController: AlertTonesViewController {
    
    public override init(style: UITableView.Style) {
        super.init(style: style)
        
        self.setupItems()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupItems()
    }
    
    private func setupItems() {
        let alertTonesManager = AlertTonesManager()
        var items = [ToneRow]()
        
        for alertTone in alertTonesManager.modernTones() {
            items.append(.tone(alertTone))
        }
        
        let classicAlertTones = alertTonesManager.classicTones()
        if (classicAlertTones.isEmpty == false) {
            items.append(.subMenu("Classic", classicAlertTones))
        }
        
        self.viewModel.items = items
    }
}
