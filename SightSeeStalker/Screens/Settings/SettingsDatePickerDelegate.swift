//
//  SettingsDatePickerDElegate.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation
import UIKit

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            self.image = selectedImage
            self.settingsModel.avatar = nil
            tableView.reloadSections([0], with: .automatic)
        }
        dismiss(animated: true, completion: nil)
    }
}
