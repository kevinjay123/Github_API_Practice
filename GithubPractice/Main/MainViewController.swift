//
//  MainViewController.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func setUI() {
        super.setUI()
        
        textField = UITextField(frame: CGRect.zero)
        
        textField.placeholder = "Enter Name"
        textField.textAlignment = .center
        textField.backgroundColor = .lightGray
        textField.keyboardType = .default
        textField.textColor = .black
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView?.backgroundColor = .lightGray
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        
        let stackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(collectionView!)

        stackView.spacing = 2.0
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        view.addSubview(stackView)
                
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp_topMargin)
            make.bottom.equalTo(view.snp_bottomMargin)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
        
        textField.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(60)
        }
        
        title = "GitHub"
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = viewModel as? MainViewModel else {
            return
        }
        
        let input = MainViewModel.Input(trigger: rx.viewWillAppear.mapToVoid())
        let output = viewModel.transform(input: input)
        
    }
}
