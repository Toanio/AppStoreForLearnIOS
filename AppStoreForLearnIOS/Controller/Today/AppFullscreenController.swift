//
//  AppFullscreenController.swift
//  AppStoreForLearnIOS
//
//  Created by c.toan on 08.12.2022.
//

import UIKit

class AppFullscreenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dismissHandler: (() -> ())?
    var todayItem: TodayItem?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
    }
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.dataSource = self
        tableView.delegate = self
        
        setupCloseButton()
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        setupFloatingControls()
    }
    
    private func setupFloatingControls() {
        let floatingControlView = UIView()
        //floatingControlView.backgroundColor = .red
        floatingControlView.layer.cornerRadius = 16
        view.addSubview(floatingControlView)
        let bottomPadding = UIApplication.shared.statusBarFrame.height
        floatingControlView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: bottomPadding, right: 16), size: .init(width: 0, height: 100))
        
        let blurVisualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        floatingControlView.addSubview(blurVisualEffect)
        blurVisualEffect.fillSuperview()
        
        let imageView = UIImageView(cornerRadius: 16)
        imageView.image = todayItem?.image
        imageView.constrainWidth(constant: 68)
        imageView.constrainHeight(constant: 68)
        
        let getButton = UIButton(title: "GET")
        getButton.setTitleColor(.white, for: .normal)
        getButton.backgroundColor = .darkGray
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getButton.layer.cornerRadius = 16
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                UILabel(text: "Life hack", font: .boldSystemFont(ofSize: 18)),
                UILabel(text: "Utilizaing your Time", font: .systemFont(ofSize: 16)),
            ], spacing: 4),
            getButton,
        ], customSpacing: 16)
        floatingControlView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        stackView.alignment = .center
    }
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "close_button"), for: .normal)
        return button
    }()
    
    private func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 40))
        closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let headerCell = AppFullscreenHeaderCell()
            headerCell.todayCell.todayItem = todayItem
            headerCell.todayCell.layer.cornerRadius = 0
            headerCell.clipsToBounds = true
            headerCell.todayCell.backgroundView = nil
            return headerCell
        }
        let cell = AppFullscreenDescriptionCell()
        return cell
    }
    
    @objc fileprivate func handleDismiss(button: UIButton ) {
        button.isHidden = true
        dismissHandler?()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return TodayController.cellSize
        }
        return UITableView.automaticDimension
        
    }
    
    
}
