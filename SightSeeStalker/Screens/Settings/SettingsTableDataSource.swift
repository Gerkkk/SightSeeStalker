//
//  SettingsDataSource.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation
import UIKit
import KeychainSwift

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        for subview in cell.contentView.subviews {
            if let tl = cell.textLabel {
                if tl != subview || indexPath.section == 0 {
                    subview.removeFromSuperview()
                }
            }
        }
        
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor.viewColor
            let cellNameLabel = UILabel()
            cell.contentView.addSubview(cellNameLabel)
            cellNameLabel.pinTop(to: cell.contentView.topAnchor, 5)
            cellNameLabel.pinCenterX(to: cell.contentView)
            cellNameLabel.setHeight(20)
            cellNameLabel.setWidth(120)
            cellNameLabel.text = "Avatar"
            cellNameLabel.textColor = UIColor.textMain
            cellNameLabel.textAlignment = .center
            cellNameLabel.font = UIFont.textBig
            
            if let label = cell.textLabel {
                label.isHidden = true
            }
            
            let custIm = CustomImageView(radius: 100, image: UIImage(named: "DefaultAvatar"))
            image = image ?? custIm.image
            
            if let ava = settingsModel.avatar {
                custIm.loadImage(from: "http://127.0.0.1:8000" + ava)
            }
            
            if let ava = self.image {
                custIm.image = ava
            } else {
                image = custIm.image
            }
            
            cell.contentView.addSubview(custIm)
            custIm.pinTop(to: cellNameLabel.bottomAnchor, 5)
            custIm.pinCenterX(to: cell.contentView)
            custIm.setHeight(200)
            custIm.pinBottom(to: cell.contentView.bottomAnchor)
        case 1:
            cell.textLabel?.text = "Name: "
            
            cell.backgroundColor = UIColor.viewColor
            cell.textLabel?.font = UIFont.textBig
            cell.textLabel?.textColor = UIColor.textMain
            
            let valueLabel = UILabel()
            cell.contentView.addSubview(valueLabel)
            
            if let label = cell.textLabel {
                label.isHidden = false
                label.setWidth(100)
                label.setHeight(30)
                label.pinLeft(to: cell.contentView.leadingAnchor, 5)
                label.pinCenterY(to: cell.contentView.centerYAnchor)
                
                valueLabel.pinLeft(to: label.trailingAnchor, 1)
            }
            
            
            valueLabel.font = UIFont.textBig
            valueLabel.textColor = UIColor.textMain
            valueLabel.text = settingsModel.name ?? ""
            print("Value: " + valueLabel.text!)
            valueLabel.setWidth(300)
            valueLabel.setHeight(30)
            
            if let leftLabel = cell.textLabel {
                valueLabel.pinLeft(to: leftLabel.trailingAnchor)
            }
            valueLabel.pinCenterY(to: cell.contentView)
            
        case 2:
            cell.textLabel?.text = "Tag: "
            cell.backgroundColor = UIColor.viewColor
            cell.textLabel?.font = UIFont.textBig
            cell.textLabel?.textColor = UIColor.textMain
            
            let valueLabel = UILabel()
            cell.contentView.addSubview(valueLabel)
            
            if let label = cell.textLabel {
                label.isHidden = false
                label.setWidth(100)
                label.setHeight(30)
                label.pinLeft(to: cell.contentView.leadingAnchor, 5)
                label.pinCenterY(to: cell.contentView.centerYAnchor)
                
                valueLabel.pinLeft(to: label.trailingAnchor, 1)
            }
            
            
            valueLabel.font = UIFont.textBig
            valueLabel.textColor = UIColor.textMain
            valueLabel.text = settingsModel.tag ?? ""
            valueLabel.setWidth(300)
            valueLabel.setHeight(30)
            if let leftLabel = cell.textLabel {
                valueLabel.pinLeft(to: leftLabel.trailingAnchor)
            }
            valueLabel.pinCenterY(to: cell.contentView)
        case 3:
            cell.textLabel?.text = "Status: "
            cell.backgroundColor = UIColor.viewColor
            cell.textLabel?.font = UIFont.textBig
            cell.textLabel?.textColor = UIColor.textMain
            
            let valueLabel = UILabel()
            cell.contentView.addSubview(valueLabel)
            
            if let label = cell.textLabel {
                label.isHidden = false
                label.setWidth(100)
                label.setHeight(30)
                label.pinLeft(to: cell.contentView.leadingAnchor, 5)
                label.pinCenterY(to: cell.contentView.centerYAnchor)
                
                valueLabel.pinLeft(to: label.trailingAnchor, 1)
            }
            
            
            valueLabel.font = UIFont.textBig
            valueLabel.textColor = UIColor.textMain
            valueLabel.text = settingsModel.status ?? ""
            valueLabel.setWidth(300)
            valueLabel.setHeight(30)
            if let leftLabel = cell.textLabel {
                valueLabel.pinLeft(to: leftLabel.trailingAnchor)
            }
            valueLabel.pinCenterY(to: cell.contentView)
        case 4:
            cell.backgroundColor = UIColor.clear
            
            let saveButton: UIButton = {
                let button = UIButton(type: .system)
                button.setTitle("Save Changes", for: .normal)
                button.backgroundColor = UIColor.customGreen
                button.titleLabel?.textColor = .black
                return button
            }()
            cell.contentView.addSubview(saveButton)
            saveButton.setHeight(40)
            saveButton.setWidth(100)
            saveButton.pinTop(to: cell.contentView.topAnchor, 5)
            saveButton.pinCenterX(to: cell.contentView)
            saveButton.pinBottom(to: cell.contentView.bottomAnchor, 5)
            saveButton.layer.cornerRadius = 10
            saveButton.setTitleColor(UIColor.backgroundCol, for: .normal)
            saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            
        default:
            break
        }
        
        return cell
    }
    
    @objc func saveButtonTapped() {
        let kc = KeychainSwift()
        guard let idStr = kc.get("id") else { return }
        let id = Int(idStr)
        
        presenter.updateSettings(image: ((self.image ?? UIImage(named: "DefaultAvatar"))!), json: ["id": id, "name": self.settingsModel.name ?? "", "tag": self.settingsModel.tag as Any, "status": self.settingsModel.status as Any])
        navigationController?.popViewController(animated: true)
    }
}
