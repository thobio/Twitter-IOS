//
//  FeedController.swift
//  Twitter IOS
//
//  Created by Coding Crackers on 08/05/20.
//  Copyright © 2020 Coding Crackers. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "TweetsCell"

class FeedController: UICollectionViewController {
    
    //MARK:- Properties
    var user:User? {
        didSet {
            configureNavigationLeftImageUI()
        }
    }
    
    var tweets:[Tweet]? {
        didSet {
            collectionView.reloadData()
        }
    }
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
    }
    //M<Ak: - API
    func fetchTweets(){
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets
        }
    }
    
    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    func configureNavigationLeftImageUI(){
        guard let users = user else{return}
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterBlue
        profileImageView.sd_setImage(with: users.profileImageURl,completed: nil)
        profileImageView.setDimensions(width: 32, height: 32)
        
        profileImageView.layer.cornerRadius = 32/2
        profileImageView.layer.masksToBounds = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = self.tweets?[indexPath.row]
        return cell
    }
}
extension FeedController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
