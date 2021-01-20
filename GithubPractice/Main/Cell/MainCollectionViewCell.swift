//
//  MainCollectionViewCell.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        avatarImageView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
        userNameLabel.text = nil
    }
}
