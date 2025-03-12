//
//  SettingsViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 26.02.2025.
//


import UIKit


final class SettingsViewController: UIViewController, SettingsViewProtocol {
    var presenter: SettingsPresenterProtocol!
    var settingsModel: SettingsModel = SettingsModel(id: -1, name: "", tag: "", status: "", avatar: nil)
    var image: UIImage?
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alwaysBounceHorizontal = false
        sv.clipsToBounds = false
        return sv
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ArrowLeft"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = UIColor.customGreen
        return button
    }()
    
    private let pageNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.textColor = UIColor.textMain
        label.font = UIFont.textBig
        return label
    }()
    
    internal let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundCol
        
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        scrollView.pinBottom(to: view.bottomAnchor)
        scrollView.pinLeft(to: view.leadingAnchor)
        scrollView.pinRight(to: view.trailingAnchor)
        
        scrollView.addSubview(backButton)
        backButton.pinLeft(to: scrollView.leadingAnchor, 10)
        backButton.pinTop(to: scrollView.topAnchor, 2)
        backButton.setWidth(20)
        backButton.setHeight(30)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        scrollView.addSubview(pageNameLabel)
        pageNameLabel.pinCenterX(to: scrollView)
        pageNameLabel.pinTop(to: scrollView.topAnchor, 2)
        
        setupTableView()
    }
    
    private func setupTableView() {
        scrollView.addSubview(tableView)
        tableView.pinTop(to: pageNameLabel.bottomAnchor, 5)
        tableView.pinLeft(to: view.leadingAnchor)
        tableView.pinRight(to: view.trailingAnchor)
        tableView.setHeight(1000)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
    }
    
    @objc private func backButtonTapped() {
        presenter.navigateBack()
    }
    
    func updateSettings(with model: SettingsModel) {
        settingsModel = model
        
        tableView.reloadData()
    }
}

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
                    //self?.tableView.reloadRows(at: [indexPath], with: .automatic)
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
                    //self?.tableView.reloadRows(at: [indexPath], with: .automatic)
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
                    //self?.tableView.reloadRows(at: [indexPath], with: .automatic)
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


extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("AAAAA")
        if let selectedImage = info[.originalImage] as? UIImage {
            self.image = selectedImage
            self.settingsModel.avatar = nil
            print("BBBB")
            //tableView.reloadData()
            tableView.reloadSections([0], with: .automatic)
        }
        dismiss(animated: true, completion: nil)
    }
}
