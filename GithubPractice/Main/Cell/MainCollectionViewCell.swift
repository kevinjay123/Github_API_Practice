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
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
        
        avatarImageView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
        userNameLabel.text = nil
    }
}
