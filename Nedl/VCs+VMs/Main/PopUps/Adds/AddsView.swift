//
//  AddsView.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-03.
//

import UIKit

protocol AddsViewDelegate {
    func didTapOnExitBtn(action: String)
}

class AddsView: UIView {

    // MARK: - Variables
    static let instance = AddsView()
    var delegate : AddsViewDelegate?
    
    private let cellIdentifier = "AdsTVCell"
    
    let data = AdsViewData()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var adsTableView: UITableView! {
        didSet {
            adsTableView.delegate = self
            adsTableView.dataSource = self
        }
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("AddsView", owner: self, options: nil)
        data.getAds()
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commomInit() {
        
        // Parentview Properties
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        registerCell()
    }
    
    func showAdView(from vc: UIViewController) {
        self.delegate = vc as? AddsViewDelegate
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    func registerCell() {
        self.adsTableView.reloadData()
        self.adsTableView.register(UINib(nibName: "AdsTVCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    @IBAction func didTapOnCloseBtn(_ sender: UIButton) {
        delegate?.didTapOnExitBtn(action: "Exit")
        parentView.removeFromSuperview()
    }
    
}

extension AddsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.arrAds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AdsTVCell", for: indexPath) as? AdsTVCell {
            cell.configCell(model: data.arrAds[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}
