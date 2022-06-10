//
//  AlertTonesViewController.swift
//  AlertTones
//
//  Created by Duncan Cunningham on 5/13/22.
//

import Foundation
import AudioToolbox
import UIKit

@objc
public protocol AlertTonesViewControllerDelegate: class {
    
    func didSelectAlertTone(alertTone: AlertTone)
}

@objc
public protocol AlertTonesViewControllerDataSource: class {
    
    var selectedAlertTone: AlertTone? { get }
}

internal enum ToneRow {
    case tone(AlertTone)
    case subMenu(String, [AlertTone])
}

internal struct AlertTonesViewControllerViewModel {
    internal var items = [ToneRow]()
    internal var selectedIndexPath: IndexPath?
}

public class AlertTonesViewController: UITableViewController {
    
    public var dataSource: AlertTonesViewControllerDataSource? {
        didSet {
            let selectedIndexPath: IndexPath? = {
                guard let selectedAlertTone = self.dataSource?.selectedAlertTone else {
                    return nil
                }
                
                for (index, toneRow) in self.viewModel.items.enumerated() {
                    switch (toneRow) {
                    case .tone(let alertTone):
                        if (alertTone == selectedAlertTone) {
                            return IndexPath(row: index, section: 0)
                        }
                    case .subMenu(_, let alertTones):
                        if (alertTones.contains(selectedAlertTone) == true) {
                            return IndexPath(row: index, section: 0)
                        }
                    }
                }
                
                return nil
            }()
            
            self.viewModel.selectedIndexPath = selectedIndexPath
        }
    }
    
    public weak var delegate: AlertTonesViewControllerDelegate?
    
    internal var viewModel = AlertTonesViewControllerViewModel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.count
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        
        if case let .tone(alertTone) = self.viewModel.items[indexPath.row] {
            cell.textLabel?.text = alertTone.name
            
            if
                let selectedAlertTone = self.dataSource?.selectedAlertTone,
                (selectedAlertTone == alertTone) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else if case let .subMenu(title, alertTones) = self.viewModel.items[indexPath.row] {
            cell.textLabel?.text = title
            cell.accessoryType = .disclosureIndicator
            
            if
                let selectedAlertTone = self.dataSource?.selectedAlertTone,
                alertTones.contains(selectedAlertTone) {
                    cell.detailTextLabel?.text = selectedAlertTone.name
            }
        }
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if case let .tone(alertTone) = self.viewModel.items[indexPath.row] {
            self.removeSelectedCheckmark()
            self.addSelectedCheckmark(indexPath: indexPath)

            var soundID: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(alertTone.url as CFURL, &soundID)

            AudioServicesPlaySystemSound(soundID)
            
            self.delegate?.didSelectAlertTone(alertTone: alertTone)
        } else if case let .subMenu(title, alertTones) = self.viewModel.items[indexPath.row] {
            let alertTonesViewController = AlertTonesViewController(style: .grouped)
            alertTonesViewController.title = title
            alertTonesViewController.viewModel.items = alertTones.map { .tone($0) }
            alertTonesViewController.delegate = self
            alertTonesViewController.dataSource = self.dataSource
            
            if let navigationController = self.navigationController {
                navigationController.pushViewController(alertTonesViewController, animated: true)
            } else {
                self.present(alertTonesViewController, animated: true, completion: nil)
            }
        }
    }
    
    private func removeSelectedCheckmark() {
        if
            let selectedIndexPath = self.viewModel.selectedIndexPath,
            let selectedCell = tableView.cellForRow(at: selectedIndexPath) {
                switch (self.viewModel.items[selectedIndexPath.row]) {
                case .tone:
                    selectedCell.accessoryType = .none
                case .subMenu:
                    selectedCell.detailTextLabel?.text = ""
                    selectedCell.accessoryType = .disclosureIndicator
                }
        }
        
        self.viewModel.selectedIndexPath = nil
    }
    
    @discardableResult
    private func addSelectedCheckmark(indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        self.viewModel.selectedIndexPath = indexPath
        return cell
    }
}

extension AlertTonesViewController: AlertTonesViewControllerDelegate {
    
    public func didSelectAlertTone(alertTone: AlertTone) {
        self.removeSelectedCheckmark()
        
        let indexPath = IndexPath(row: self.viewModel.items.count - 1, section: 0)
        self.viewModel.selectedIndexPath = indexPath
        let cell = tableView.cellForRow(at: indexPath)
        cell?.detailTextLabel?.text = alertTone.name
        
        self.delegate?.didSelectAlertTone(alertTone: alertTone)
    }
}
