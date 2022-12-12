//
//  TodayMultipleAppController.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 11.12.2022.
//

import UIKit

class TodayMultipleAppController: BaseListController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    var result = [AppsResult]()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "close_button"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handlerDismiss), for: .touchUpInside)
        return button
    }()
    
    @objc func handlerDismiss(button: UIButton) {
        dismiss(animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = self.result[indexPath.item].id
        let appDetailController = AppDetailController(appId: appId)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        if mode == .fullscreen {
            setupCloseButton()
            navigationController?.isNavigationBarHidden = true
        } else {
            collectionView.isScrollEnabled = false
        }
    
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    override var prefersStatusBarHidden: Bool { return true}
    
    func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullscreen {
            return .init(top: 12, left: 24, bottom: 12, right: 24)
        }
        return .zero
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .fullscreen {
            return result.count
        }
        return min(4, result.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppCell
        cell.app = self.result[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 68
        if mode == .fullscreen {
            return .init(width: view.frame.width - 48, height: height)
        }
        return .init(width: view.frame.width, height: height)
    }
    
    private let spacing: CGFloat = 16
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    private let mode: Mode
    
    enum Mode {
    case small, fullscreen
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
