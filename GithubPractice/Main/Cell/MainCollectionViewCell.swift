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

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 15.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.masksToBounds = true

        avatarImageView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        avatarImageView.image = nil
        userNameLabel.text = nil
    }
}
