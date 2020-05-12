//
//  LogingController.swift
//  Twitter IOS
//
//  Created by Coding Crackers on 08/05/20.
//  Copyright © 2020 Coding Crackers. All rights reserved.
//

import UIKit

class LogingController: UIViewController {
    
    //MARK: - Properties
    
    private let logoImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "TwitterLogo")
        return imageView
    }()
    
    private lazy var emailContainerView:UIView = {
        let images = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: images, textField: emailText)
        return view
    }()
    
    private lazy var passwordContainerView:UIView = {
        let images = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: images, textField: passwordText)
        return view
    }()
    
    private let emailText:UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        return tf
    }()
    
    private let passwordText:UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    private let downNavigationButton:UIButton = {
        let button = Utilities().attributedButton("Dont have an account? ", "Sign up")
        button.addTarget(self, action: #selector(handleShowSignup), for: .touchUpInside)
        return button
    }()
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleLogin(){
        guard let email = emailText.text else{return}
        guard let password = passwordText.text else {return}
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                 print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            //print("DEBUG: Succeddful log in ...")
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {return}
            guard let tab = window.rootViewController as? MainTabController else{return}
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func handleShowSignup (){
        let controller = RegistrationController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - Helper
    func configureUI(){
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingLeft: 32,paddingRight: 32)
        view.addSubview(downNavigationButton)
        downNavigationButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 20, height: 50)
    }
}
