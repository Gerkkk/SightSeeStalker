//
//  AuthViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 06.02.2025.
//

import UIKit

final class AuthViewController: UIViewController {
    
    var presenter = AuthPresenter()
    
    private let imageView: UIImageView = {
        let imageField = UIImageView()
        imageField.image = UIImage(named: "AppIcon")
        imageField.setHeight(300)
        return imageField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.viewColor
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Tag",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.textSupporting]
        )
        
        textField.keyboardAppearance = .dark
        textField.keyboardType = .webSearch
        
        textField.textColor = UIColor.textMain
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.viewColor
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.textSupporting]
        )
        
        textField.keyboardAppearance = .dark
        textField.keyboardType = .webSearch

        textField.textColor = UIColor.textMain
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        
        button.backgroundColor = UIColor.customGreen
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.backgroundCol
        let stackView = UIStackView(arrangedSubviews: [imageView, emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        stackView.pinCenter(to: view)
        stackView.pinCenterY(to: view)
        stackView.setWidth(300)
    }
    
    @objc private func loginTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        presenter.login(email: email, password: password)
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

