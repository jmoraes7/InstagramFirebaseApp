//
//  UserProfileHeader.swift
//  Instagram
//
//  Created by Julian on 11/24/17.
//  Copyright © 2017 Julian. All rights reserved.
//

import UIKit

class UserProfileHeader : UICollectionViewCell {
    
    var user: UserInfo? {
        didSet {
            setUpProfileImage()
            
            usernameLabel.text = user?.username
        }
    }
    
    let profileImageView : UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let postsLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "11\n",
                                                       attributes: [NSFontAttributeName:
                                                        UIFont.boldSystemFont(ofSize: 14)])
                                                        
        attributedText.append(NSAttributedString(string: "posts", attributes: [NSForegroundColorAttributeName:
            UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()

        let attributedText = NSMutableAttributedString(string: "0\n",
                                                       attributes: [NSFontAttributeName:
                                                        UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "followers", attributes: [NSForegroundColorAttributeName:
            UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()

        let attributedText = NSMutableAttributedString(string: "0\n",
                                                       attributes: [NSFontAttributeName:
                                                        UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "following", attributes: [NSForegroundColorAttributeName:
            UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, right: nil, bottom: nil, left: self.leftAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        setUpBottomToolbar()
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImageView.bottomAnchor, right: rightAnchor, bottom: gridButton.topAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        setupUserStatsView()
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: postsLabel.bottomAnchor, right: followingLabel.rightAnchor, bottom: nil, left: postsLabel.leftAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 34)

    }
    
    fileprivate func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel,
                                                       followersLabel, followingLabel])
        
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, right: rightAnchor, bottom: nil, left: profileImageView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 50)
        
    }
    
    fileprivate func setUpBottomToolbar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: nil, right: rightAnchor, bottom: bottomAnchor, left: leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        topDividerView.anchor(top: stackView.topAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }

    
    fileprivate func setUpProfileImage() {
        
        guard let profileImageUrl = user?.profileImageUrl else {
            return
        }
        
        guard let url = URL(string: profileImageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch profile image", err)
                return
            }
            
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            
            
            }.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
