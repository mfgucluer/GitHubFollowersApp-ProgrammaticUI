//
//  FavoriteCell.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 16/2/24.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID  = "FavoriteCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel   = GFTitleLabel(textAligment: .left, fontSize: 26)
       
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           configure()
       }
       
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       
       func set(favorite: Follower) {
           usernameLabel.text = favorite.login
           avatarImageView.downloadImage(from: favorite.avatarUrl)
       }
       
       
       private func configure() {
           addSubview(avatarImageView)
           addSubview(usernameLabel)
           
           accessoryType           = .disclosureIndicator
           let padding: CGFloat    = 12
           
           NSLayoutConstraint.activate([
               avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
               avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
               avatarImageView.heightAnchor.constraint(equalToConstant: 60),
               avatarImageView.widthAnchor.constraint(equalToConstant: 60),
               
               usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
               usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
               usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
               usernameLabel.heightAnchor.constraint(equalToConstant: 40)
           ])
       }

}
