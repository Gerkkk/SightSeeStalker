//
//  SettingsViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 26.02.2025.
//

//import UIKit
//
//final class SettingsViewController: UIViewController {
//    
//    private let backButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named:"ArrowLeft"), for: .normal)
//        button.backgroundColor = .clear
//        button.tintColor = UIColor.customGreen
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.addSubview(backButton)
//        backButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 10)
//        backButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 2)
//        backButton.setWidth(20)
//        backButton.setHeight(30)
//        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//        
//        view.backgroundColor = UIColor.backgroundCol
//        
//    }
//    
//    @objc func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//
//}

import UIKit

class SettingsViewController: UIViewController {

    var personModel: PersonModel?

    private let tableView = UITableView()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"ArrowLeft"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = UIColor.customGreen
        return button
    }()
    
    // Тексты для редактирования
    private var name: String = ""
    private var tag: String = ""
    private var status: String = ""
    private var avatar: UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundCol
        
        title = "Edit Profile"
        
        setupTableView()
        setupSaveButton()
        
        if let person = personModel {
            name = person.name ?? ""
            tag = person.tag ?? ""
            status = person.status ?? ""
//            avatar = person.avatar ?? UIImage()
        }
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }
    
    private func setupSaveButton() {
        let saveButton = UIButton(type: .system)
        saveButton.frame = CGRect(x: 20, y: view.bounds.height - 60, width: view.bounds.width - 40, height: 50)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        view.addSubview(saveButton)
    }
    
    @objc private func saveChanges() {
        print("Changes saved: \(name), \(tag), \(status)")
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "Name"
            cell.detailTextLabel?.text = name
            cell.backgroundColor = UIColor.viewColor
        case 1:
            cell.textLabel?.text = "Tag"
            cell.detailTextLabel?.text = tag
            cell.backgroundColor = UIColor.viewColor
        case 2:
            cell.textLabel?.text = "Status"
            cell.detailTextLabel?.text = status
            cell.backgroundColor = UIColor.viewColor
        case 3:
            cell.textLabel?.text = "Avatar"
            cell.backgroundColor = UIColor.viewColor
            if let avatarImage = avatar {
                cell.imageView?.image = avatarImage
            }
        default:
            break
        }
        
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertController: UIAlertController
        
        
        switch indexPath.section {
        case 0:
            alertController = UIAlertController(title: "Edit Name", message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.text = self.name
            }
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
                if let newName = alertController.textFields?.first?.text {
                    self.name = newName
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }))
        case 1:
            alertController = UIAlertController(title: "Edit Tag", message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.text = self.tag
            }
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
                if let newTag = alertController.textFields?.first?.text {
                    self.tag = newTag
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }))
        case 2:
            alertController = UIAlertController(title: "Edit Status", message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.text = self.status
            }
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
                if let newStatus = alertController.textFields?.first?.text {
                    self.status = newStatus
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }))
        case 3:
            alertController = UIAlertController(title: "Edit Avatar", message: "Choose a photo", preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                self.presentImagePicker(sourceType: .camera)
            }))
            alertController.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
                self.presentImagePicker(sourceType: .photoLibrary)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
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

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            avatar = selectedImage
            tableView.reloadSections([3], with: .automatic)
        }
        dismiss(animated: true, completion: nil)
    }
}
