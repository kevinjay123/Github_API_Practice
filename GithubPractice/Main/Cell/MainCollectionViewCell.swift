//
//  MainCollectionViewCell.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet var baseView: UIView!

    @IBOutlet var avatarImageView: UIImageView!

    @IBOutlet var userNameLabel: UILabel!

    private var user: User? {
        didSet {
            if let user = user {
                let url = URL(string: user.avatarUrlString)

                avatarImageView.kf.setImage(with: url)
                userNameLabel.text = user.name
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 15.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.masksToBounds = true

        avatarImageView.clipsToBounds = true
    }
    
    func bind(for user: User) {
        self.user = user
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        avatarImageView.image = nil
        userNameLabel.text = nil
    }
}
