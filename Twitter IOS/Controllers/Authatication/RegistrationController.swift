//
//  RegistrationController.swift
//  Twitter IOS
//
//  Created by Coding Crackers on 08/05/20.
//  Copyright © 2020 Coding Crackers. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrationController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK: - Properties
    private let imagePicker = UIImagePickerController()
    private var profileImage:UIImage?
    
    private lazy var logoImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "plus_photo")
        imageView.tintColor = .white
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imagePickerSelect)))
        imageView.isUserInteractionEnabled = true
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
    private lazy var fullNameContainerView:UIView = {
        let images = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: images, textField: fullNameText)
        return view
    }()
    private lazy var usernameContainerView:UIView = {
        let images = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: images, textField: userNameText)
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
    private let fullNameText:UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Full Name")
        return tf
    }()
    private let userNameText:UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Username")
        return tf
    }()
    
    private let sigupButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    private let downNavigationButton:UIButton = {
        let button = Utilities().attributedButton("Already have an account? ", "Log In")
        button.addTarget(self, action: #selector(handleShowSignup), for: .touchUpInside)
        return button
    }()
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func imagePickerSelect(){
        present(imagePicker, animated: true, completion: nil)
    }
    @objc func handleLogin(){
        guard let profile = self.profileImage else {
            print("DEBUG: Please Select the profile Image")
            return
        }
        guard let email = emailText.text else {return}
        guard let password = passwordText.text else {return}
        guard let fullname = fullNameText.text else {return}
        guard let username = userNameText.text?.lowercased() else {return}
        
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profile)
        
        AuthService.shared.registerUser(credentials: credentials) { (error, dataRefe) in
            if let error = error {
                print("DEBUG: Error Found is \(error)")
                return
            }
            //print("DEBUG: Successfully updated user information ..")
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {return}
            guard let tab = window.rootViewController as? MainTabController else{return}
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func handleShowSignup (){
        self.navigationController?.popToRootViewController(animated: true)
    }
    //MARK: - Helper
    func configureUI(){
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 128, height: 128)
        logoImageView.layer.cornerRadius = 128/2
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,fullNameContainerView,usernameContainerView,sigupButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingLeft: 32,paddingRight: 32)
        
        view.addSubview(downNavigationButton)
        downNavigationButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 20, height: 50)
    }
}
extension RegistrationController {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {
            return
        }
        logoImageView.image = profileImage.withRenderingMode(.alwaysOriginal)
        self.profileImage = logoImageView.image
        logoImageView.layer.masksToBounds = true
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.clipsToBounds = true
        logoImageView.layer.borderColor = UIColor.white.cgColor
        logoImageView.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)
    }
}
