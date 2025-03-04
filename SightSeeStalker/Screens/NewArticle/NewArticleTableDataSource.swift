//
//  NewArticleTableDataSource.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 04.03.2025.
//

import UIKit

extension NewArticleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewArticleTableCell", for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.backgroundColor = UIColor.clear
        
        switch indexPath.row {
        case 0:
            let textField = createTextField(placeholder: "Enter article name")
            cell.contentView.addSubview(textField)
            
            textField.pinTop(to: cell.contentView.topAnchor, 5)
            textField.pinLeft(to: cell.contentView.leadingAnchor, 10)
            textField.pinRight(to: cell.contentView.trailingAnchor, 10)
            textField.pinBottom(to: cell.contentView.bottomAnchor, 5)
        
        case 1:
            let coordinateStack = UIStackView()
            coordinateStack.axis = .horizontal
            coordinateStack.spacing = 10
            coordinateStack.distribution = .fillProportionally
                
            let dateLabel = UILabel()
            dateLabel.text = "Select the date of travel"
            dateLabel.font = UIFont.textTertiary
            dateLabel.textColor = UIColor.textMain
            
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.tintColor = UIColor.customGreen
            datePicker.backgroundColor = .clear
            datePicker.preferredDatePickerStyle = .compact
            
            coordinateStack.addArrangedSubview(dateLabel)
            coordinateStack.addArrangedSubview(datePicker)
        
            cell.contentView.addSubview(coordinateStack)
            
            coordinateStack.pinTop(to: cell.contentView.topAnchor, 5)
            coordinateStack.pinLeft(to: cell.contentView.leadingAnchor, 10)
            coordinateStack.pinRight(to: cell.contentView.trailingAnchor, 10)
            coordinateStack.pinBottom(to: cell.contentView.bottomAnchor, 5)
            
        case 2:
            let coordinateStack = UIStackView()
            coordinateStack.axis = .horizontal
            coordinateStack.spacing = 10
            coordinateStack.distribution = .fillProportionally
            
            let latField = createTextField(placeholder: "Latitude (15.12)")
            let lonField = createTextField(placeholder: "Longitude (34.0)")
            
            coordinateStack.addArrangedSubview(latField)
            coordinateStack.addArrangedSubview(lonField)
            
            cell.contentView.addSubview(coordinateStack)
            
            coordinateStack.pinTop(to: cell.contentView.topAnchor, 5)
            coordinateStack.pinLeft(to: cell.contentView.leadingAnchor, 10)
            coordinateStack.pinRight(to: cell.contentView.trailingAnchor, 10)
            coordinateStack.pinBottom(to: cell.contentView.bottomAnchor, 5)
        
        case 3:
            let textView = createTextView()
            cell.contentView.addSubview(textView)
            textView.setHeight(70)
            textView.pinTop(to: cell.contentView.topAnchor, 5)
            textView.pinLeft(to: cell.contentView.leadingAnchor, 10)
            textView.pinRight(to: cell.contentView.trailingAnchor, 10)
            textView.pinBottom(to: cell.contentView.bottomAnchor, 5)
        case 4:
            let textView = createTextView()
            cell.contentView.addSubview(textView)
            textView.setHeight(200)
            textView.pinTop(to: cell.contentView.topAnchor, 5)
            textView.pinLeft(to: cell.contentView.leadingAnchor, 10)
            textView.pinRight(to: cell.contentView.trailingAnchor, 10)
            textView.pinBottom(to: cell.contentView.bottomAnchor, 5)
        default:
            break
        }
        
        return cell
    }
    
    private func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.textTertiary
        textField.keyboardAppearance = UIKeyboardAppearance.dark
        textField.keyboardType = UIKeyboardType.webSearch
        
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.textSupporting]
        )
        
        textField.layer.borderColor = UIColor.viewEdging.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        
        textField.backgroundColor = UIColor.viewColor
        textField.textColor = UIColor.textMain
        return textField
    }
    
    private func createTextView() -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.viewEdging.cgColor
        textView.layer.cornerRadius = 5
        textView.font = UIFont.textSecondary
        textView.keyboardAppearance = UIKeyboardAppearance.dark
        textView.keyboardType = UIKeyboardType.webSearch
        
        textView.backgroundColor = UIColor.viewColor
        textView.textColor = UIColor.textMain
        return textView
    }
}
