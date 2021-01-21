//
//  MainViewController.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Kingfisher

class MainViewController: BaseViewController {
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: CGRect.zero)
        return textField
    }()
    
    private var collectionView: UICollectionView = {
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
    }
    
    override func setUI() {
        super.setUI()
        
        textField.placeholder = NSLocalizedString("Main.TextField.Placeholder.Text", comment: "Placeholder.Text")
        textField.textAlignment = .center
        textField.backgroundColor = .darkGray
        textField.keyboardType = .default
        textField.textColor = .white
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        
        collectionView.backgroundColor = .darkGray
        collectionView.keyboardDismissMode = .onDrag
        
        let nib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "mainCell")
        
        let stackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(collectionView)

        stackView.spacing = 2.0
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        view.addSubview(stackView)
                
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp_topMargin)
            make.bottom.equalTo(view.snp.bottom)
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

        let input = MainViewModel.Input(reachedBottomTrigger: collectionView.rx.reachedBottom.mapToVoid())
        let output = viewModel.transform(input: input)
        
        output.sectionModels
            .bind(to: collectionView.rx.items(dataSource: genDataSource()))
            .disposed(by: rx.disposeBag)
        
        textField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self, let text = self.textField.text else { return }
                
                viewModel.fetchSearchResult(by: text)
                
                self.textField.resignFirstResponder()
            })
            .disposed(by: rx.disposeBag)
        
        viewModel.loading.asObservable()
            .bind(to: isLoading)
            .disposed(by: rx.disposeBag)
        
        viewModel.parsedError.asObservable()
            .bind(to: error)
            .disposed(by: rx.disposeBag)

        isLoading.asDriver()
            .drive(onNext: { [weak self] isLoading in
                isLoading ? self?.showHUD() : self?.dismissHUD(isAnimated: false)
            })
            .disposed(by: rx.disposeBag)

        error
            .subscribe(onNext: { [weak self] error in
                let alerVC = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
                alerVC.addAction(.init(title: NSLocalizedString("UI.OK", comment: "UI.OK"), style: .default, handler: nil))
                self?.present(alerVC, animated: true, completion: nil)
            })
            .disposed(by: rx.disposeBag)
    }
    
    private func genDataSource() -> RxCollectionViewSectionedReloadDataSource<MainSectionModel> {
        return RxCollectionViewSectionedReloadDataSource<MainSectionModel> { (dataSource, collectionView, indexPath, model) -> UICollectionViewCell in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainCollectionViewCell
            
            switch dataSource[indexPath] {
            case let .list(item):
                let url = URL(string: item.avatarUrlString)
                
                cell.avatarImageView.kf.setImage(with: url)
                cell.userNameLabel.text = item.name
            }
            
            return cell
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    fileprivate var sectionInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 16.0, left: 0.0, bottom: 16.0, right: 0.0)
    }

    fileprivate var itemsPerRow: CGFloat {
        return 2
    }

    fileprivate var interItemSpace: CGFloat {
        return 8.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionPadding = sectionInsets.left * (itemsPerRow + 1)
        let interItemPadding = max(0.0, itemsPerRow - 1) * interItemSpace
        let availableWidth = collectionView.bounds.width - sectionPadding - interItemPadding + sectionInsets.left
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpace
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpace
    }
}
