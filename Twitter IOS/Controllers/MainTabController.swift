//
//  MainTabController.swift
//  Twitter IOS
//
//  Created by Coding Crackers on 08/05/20.
//  Copyright © 2020 Coding Crackers. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    var users : User?{
        didSet{
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            feed.user = users
        }
    }
    
    lazy var actionButton:UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
        //logUserOut()
        authenticateUserAndConfigureUI()
        
    }
    //MARK: - API
    func fetchUser(){
         guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.shared.fetchUser(uid: uid) { user in
            self.users = user
        }
    }
    func authenticateUserAndConfigureUI(){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LogingController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }else{
            configureViewControllers()
            configureUI()
            fetchUser()
        }
    }
    func logUserOut(){
        do{
            try Auth.auth().signOut()
        }catch let error {
            print("DEBUG:Failed to sign out with error \(error.localizedDescription)")
        }
    }
    //MARK:- Selector
    @objc func actionButtonTapped(){
        guard let user = users else {return}
        let controller = UploadTweetController(user: user)
       let nav = UINavigationController(rootViewController: controller)
        //nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    func configureUI(){
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 20, width: 56, height: 56)
        actionButton.layer.cornerRadius = (56 / 2)
    }
    
    func configureViewControllers(){
        
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav1 = templeteNavigationController(image: UIImage(named: "home_unselected")!, rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templeteNavigationController(image: UIImage(named: "search_unselected")!, rootViewController: explore)
        
        let noticifations = NotificationController()
        let nav3 = templeteNavigationController(image: UIImage(named: "like_unselected")!, rootViewController: noticifations)
        
        let conversations = ConversationsController()
        let nav4 = templeteNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1")!, rootViewController: conversations)
        
        viewControllers = [nav1,nav2,nav3,nav4]
    }
    
    func templeteNavigationController(image:UIImage,rootViewController:UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        
        return nav
    }
}
