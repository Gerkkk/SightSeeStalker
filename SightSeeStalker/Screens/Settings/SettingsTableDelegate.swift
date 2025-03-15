//
//  SettingsTableDelegate.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation
import UIKit

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertController: UIAlertController
        
        
        switch indexPath.section {
        case 0:
            alertController = UIAlertController(title: "Edit Avatar", message: "Choose a photo", preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                self.presentImagePicker(sourceType: .camera)
            }))
            alertController.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
                self.presentImagePicker(sourceType: .photoLibrary)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        case 1:
            alertController = UIAlertController(title: "Edit Name", message: nil, preferredStyle: .alert)
            alertController.addTextField {[weak self] textField in
                textField.text = self?.settingsModel.name ?? ""
            }
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {[weak self] _ in
                if let newName = alertController.textFields?.first?.text {
                    self?.settingsModel.name = newName
                    self?.tableView.reloadData()
                }
            }))
        case 2:
            alertController = UIAlertController(title: "Edit Tag", message: nil, preferredStyle: .alert)
            alertController.addTextField { [weak self] textField in
                textField.text = self?.settingsModel.tag ?? ""
            }
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
                if let newTag = alertController.textFields?.first?.text {
                    self?.settingsModel.tag = newTag
                    self?.tableView.reloadData()
                }
            }))
        case 3:
            alertController = UIAlertController(title: "Edit Status", message: nil, preferredStyle: .alert)
            alertController.addTextField {[weak self] textField in
                textField.text = self?.settingsModel.status ?? ""
            }
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {[weak self] _ in
                if let newStatus = alertController.textFields?.first?.text {
                    self?.settingsModel.status = newStatus
                    self?.tableView.reloadData()
                }
            }))
        default:
            return
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        }
    }
}
