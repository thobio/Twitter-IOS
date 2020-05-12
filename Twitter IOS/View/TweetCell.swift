//
//  TweetCell.swift
//  Twitter IOS
//
//  Created by Zerone on 12/05/20.
//  Copyright © 2020 Coding Crackers. All rights reserved.
//

import UIKit
import SDWebImage

class TweetCell:UICollectionViewCell {
    //MARK: - Properties
    var tweet:Tweet?{
        didSet{configure()}
    }
    private lazy var profileImageView:UIImageView = {
        let image = UIImageView()
        image.setDimensions(width: 48, height: 48)
        image.layer.cornerRadius = 48 / 2
        image.layer.masksToBounds = true
        image.backgroundColor = .twitterBlue
        return image
    }()
    private let captionLabel:UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.numberOfLines = 0
        lb.text = "Some text caption"
        return lb
    }()
    private lazy var commentButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return  button
    }()
    private lazy var retweetButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return  button
    }()
    private lazy var likeButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return  button
    }()
    private lazy var shareButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return  button
    }()
    private let infoLabel = UILabel()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 8)
        
        let stack = UIStackView(arrangedSubviews: [infoLabel,captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        addSubview(stack)
        stack.anchor(top: topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8)
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.text = "eddie brock @venom"
        let underlinView = UIView()
        underlinView.backgroundColor = .systemGroupedBackground
        addSubview(underlinView)
        underlinView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,height: 1)
        let butttonStack = UIStackView(arrangedSubviews: [commentButton,retweetButton,likeButton,shareButton])
        butttonStack.axis = .horizontal
        butttonStack.spacing = 72
        butttonStack.distribution = .equalSpacing
        addSubview(butttonStack)
        butttonStack.centerX(inView: self)
        butttonStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Selectors
    @objc func handleCommentTapped(){
        //TODO:- fill the action
    }
    @objc func handleRetweetTapped(){
        //TODO:- fill the action
    }
    @objc func handleLikeTapped(){
        //TODO:- fill the action
    }
    @objc func handleShareTapped(){
        //TODO:- fill the action
    }
    //MARK: - Helper
    func configure(){
        guard let tweet = self.tweet else {return}
        let viewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = tweet.caption
        profileImageView.sd_setImage(with: viewModel.profileImageUrl, completed: nil)
        infoLabel.attributedText = viewModel.userInfoText
    }
}
