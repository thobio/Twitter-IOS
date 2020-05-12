//
//  UploadTweetController.swift
//  Twitter IOS
//
//  Created by Zerone on 11/05/20.
//  Copyright © 2020 Coding Crackers. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase


class UploadTweetController: UIViewController {
    
    //MARK: - Properties
    private let user:User
    lazy var tweetButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .twitterBlue
        btn.tintColor = .white
        btn.setTitle("Tweet", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(saveTweet), for: .touchUpInside)
        btn.setDimensions(width: 80, height: 30)
        return btn
    }()
    private let captionTextView = CaptionTextView()
    private lazy var profileImageView:UIImageView = {
       let image = UIImageView()
        image.setDimensions(width: 48, height: 48)
        image.layer.cornerRadius = 48 / 2
        image.layer.masksToBounds = true
        image.backgroundColor = .twitterBlue
        return image
    }()
    //MARK: - Lifecycle
    init(user:User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Selectors
    @objc func dismissViewController(){
        dismiss(animated: true, completion: nil)
    }
    @objc func saveTweet(){
        guard let caption = captionTextView.text else {return}
        TweetService.shared.uploadTweet(caption: caption) { (error, reference) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            self.captionTextView.text = ""
            self.dismiss(animated: true, completion: nil)
        }
    }
    //MARK: - API
    
    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
        configureNavigationUI()
        
        let stack = UIStackView(arrangedSubviews: [profileImageView,captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        view.addSubview(stack)
        
        profileImageView.sd_setImage(with: user.profileImageURl, completed: nil)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 16, paddingLeft: 16,paddingRight: 16)
    }
    
    func configureNavigationUI(){
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,target: self, action: #selector(dismissViewController))
        
        tweetButton.layer.cornerRadius = 30/2
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }
}
