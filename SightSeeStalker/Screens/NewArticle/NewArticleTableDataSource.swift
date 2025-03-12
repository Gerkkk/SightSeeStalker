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
        return 7
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
            
            self.nameField = textField
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
            
            self.datePicker = datePicker
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
            self.coordNField = latField
            self.coordWField = lonField
        case 3:
            let textView = createTextView()
            cell.contentView.addSubview(textView)
            textView.setHeight(70)
            textView.pinTop(to: cell.contentView.topAnchor, 5)
            textView.pinLeft(to: cell.contentView.leadingAnchor, 10)
            textView.pinRight(to: cell.contentView.trailingAnchor, 10)
            textView.pinBottom(to: cell.contentView.bottomAnchor, 5)
            self.briefView = textView
        case 4:
            let textView = createTextView()
            cell.contentView.addSubview(textView)
            textView.setHeight(200)
            textView.pinTop(to: cell.contentView.topAnchor, 5)
            textView.pinLeft(to: cell.contentView.leadingAnchor, 10)
            textView.pinRight(to: cell.contentView.trailingAnchor, 10)
            textView.pinBottom(to: cell.contentView.bottomAnchor, 5)
            self.textView = textView
        case 5:
            let carouselView: ImageFromPhoneCarouselView = {
                let view = ImageFromPhoneCarouselView(images: [])
                return view
            }()
            self.imageCarousel = carouselView
            print(carouselView.images.count)
            cell.contentView.addSubview(carouselView)
            carouselView.setHeight(200)
            carouselView.translatesAutoresizingMaskIntoConstraints = false
            carouselView.pinTop(to: cell.contentView.topAnchor, 5)
            carouselView.pinLeft(to: cell.contentView.leadingAnchor, 10)
            carouselView.pinRight(to: cell.contentView.trailingAnchor, 10)
            carouselView.pinBottom(to: cell.contentView.bottomAnchor, 5)
        case 6:
            let publishButton: UIButton = {
                let button = UIButton(type: .system)
                button.setTitle("Publish Article", for: .normal)
                button.backgroundColor = UIColor.customGreen
                button.titleLabel?.textColor = .black
                return button
            }()
            cell.contentView.addSubview(publishButton)
            publishButton.setHeight(28)
            publishButton.setWidth(80)
            publishButton.pinTop(to: cell.contentView.topAnchor, 5)
            publishButton.pinCenterX(to: cell.contentView)
            publishButton.pinBottom(to: cell.contentView.bottomAnchor, 5)
            publishButton.layer.cornerRadius = 10
            publishButton.setTitleColor(UIColor.backgroundCol, for: .normal)
            publishButton.addTarget(self, action: #selector(publishButtonTapped), for: .touchUpInside)
        default:
            break
        }
        
        return cell
    }
    //TODO: replace author id, maybe guard let
    @objc func publishButtonTapped() {
        let date = Int(self.datePicker?.date.timeIntervalSince1970 ?? 0)
        let coordsN = Double(self.coordNField?.text ?? "0")
        let coordsW = Double(self.coordWField!.text ?? "0")
        
        
        var jsonInfo: [String: Any] = ["author_id": 0, "title": self.nameField?.text ?? "", "date": date, "coords_n": coordsN as Any, "coords_w": coordsW, "brief": self.briefView?.text ?? "" as Any, "text": self.textView!.text ?? ""]
        self.presenter?.publishArticle(images: imageCarousel?.images ?? [], json: jsonInfo)
//        self.uploadImagesWithJSON(images: imageCarousel?.images ?? [], json: jsonInfo)
        navigationController?.popViewController(animated: true)
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
