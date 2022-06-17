//
//  AlertTonesTableViewCell.swift
//  AlertTones
//
//  Created by Duncan Cunningham on 6/17/22.
//

import Foundation
import UIKit

public class AlertTonesTableViewCell: UITableViewCell {
    
    internal static let reuseIdentifier = "AlertTonesTableViewCell"
    
    /// Used to set the disclosure indicator tint color via the Appearance API
    @objc
    public var disclosureIndicatorColor: UIColor?
    
    /// Used to set the text color via the Appearance API, as UITableViewCell.appearance.textLabel.textColor doesn't work
    @objc
    public var mainTextColor: UIColor? {
        get {
            return self.textLabel?.textColor
        }
        
        set {
            self.textLabel?.textColor = newValue
        }
    }
    
    /// Used to set the text color via the Appearance API, as UITableViewCell.appearance.detailTextLabel.textColor doesn't work
    @objc
    public var detailTextColor: UIColor? {
        get {
            return self.detailTextLabel?.textColor
        }
        
        set {
            self.detailTextLabel?.textColor = newValue
        }
    }
    
    internal func applyDisclosureIndicatorColor() {
        guard
            (self.accessoryType == .disclosureIndicator),
            let color = self.disclosureIndicatorColor,
            let button = self.subviewButton else {
                return
        }
        
        var image = button.backgroundImage(for: .normal)
        image = image?.withRenderingMode(.alwaysTemplate)
        button.tintColor = color
        button.setBackgroundImage(image, for: .normal)
    }
    
    private var subviewButton: UIButton? {
        for view in self.subviews {
            if let button = view as? UIButton {
                return button
            }
        }
        
        return nil;
    }
}
