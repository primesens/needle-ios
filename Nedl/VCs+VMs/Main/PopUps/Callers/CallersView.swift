//
//  CallersView.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-03.
//

import UIKit
import SwiftUI

protocol CallersViewDelegate {
    func didTapOnExitBtn(action: String)
}

class CallersView: UIView, LoadingIndicatorDelegate {
    
    // MARK: - Variables
    
    static let instance = CallersView()
    var delegate : CallersViewDelegate?
    
    private let cellIdentifier = "CallTVCell"
    private let guestCVCellIdentifier = "GuestCVCell"
    private let callerCVCellIdentifier = "CallerCVCell"
    
    let data = CallData()
    
    
    @IBOutlet weak var guestStackView: UIStackView!
    @IBOutlet weak var callersStackView: UIStackView!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var callSwitch: UISwitch!
    
    @IBOutlet weak var guestColllectionView: UICollectionView! {
        didSet {
            guestColllectionView.delegate = self
            guestColllectionView.dataSource = self
        }
    }
    @IBOutlet weak var callersCollectionview: UICollectionView! {
        didSet {
            callersCollectionview.delegate = self
            callersCollectionview.dataSource = self
        }
    }
    @IBOutlet weak var callTableView: UITableView! {
        didSet {
            callTableView.delegate = self
            callTableView.dataSource = self
        }
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("CallersView", owner: self, options: nil)
        commomInit()
        loadCallers()
        guestStackView.isHidden = true
        callersStackView.isHidden = true
        
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
    
    func showCallView(from vc: UIViewController) {
        self.delegate = vc as? CallersViewDelegate
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    func registerCell() {
        self.callTableView.reloadData()
        self.callersCollectionview.reloadData()
        self.guestColllectionView.reloadData()
        self.callTableView.register(UINib(nibName: "CallTVCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.guestColllectionView.register(UINib(nibName: "GuestCVCell", bundle: nil), forCellWithReuseIdentifier: guestCVCellIdentifier)
        self.callersCollectionview.register(UINib(nibName: "CallerCVCell", bundle: nil), forCellWithReuseIdentifier: callerCVCellIdentifier)
    }
    
    
    @IBAction func didTapOnCloseBtn(_ sender: UIButton) {
        delegate?.didTapOnExitBtn(action: "Exit")
        parentView.removeFromSuperview()
    }
    
    func loadCallers() {
        self.startLoading()
        
        data.getCallers() { status, message, error in
            self.stopLoading()
            if status {
                self.callTableView.reloadData()
            } else if error != nil {
                //                self.presentAlert(title: "", message: error ?? "", buttonTitle: "OK")
                print("Fail")
            }
        }
    }
    
    func addCaller() {
        self.startLoading()
        
        data.addCaller(callerUrl: "a", callerId: 22, status: "ACCEPTED") { status, message, error in
            self.stopLoading()
            if status {
                self.callTableView.reloadData()
            } else if error != nil {
                print("Fail")
            }
        }
    }
    
    func endCaller() {
        self.startLoading()
        
        data.endCaller(callerUrl: "a", callerId: 1, status: "END") { status, message, error in
            self.stopLoading()
            if status {
                self.callTableView.reloadData()
            } else if error != nil {
                print("Fail")
            }
        }
    }
}


extension CallersView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.calleData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CallTVCell", for: indexPath) as? CallTVCell {
            //            cell.configCell(model: data.arrCalls[indexPath.row])
            //            return cell
            
            cell.configCell(with: data.calleData.value[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension CallersView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == guestColllectionView) {
            return 1
        } else if (collectionView == callersCollectionview) {
            return 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == guestColllectionView) {
            let cell: GuestCVCell = guestColllectionView.dequeueReusableCell(withReuseIdentifier: "GuestCVCell", for: indexPath) as! GuestCVCell
            //            cell.configCell(model: vm.arrHappeningNow[indexPath.row])
            return cell
        } else if (collectionView == callersCollectionview) {
            let cell: CallerCVCell = callersCollectionview.dequeueReusableCell(withReuseIdentifier: "CallerCVCell", for: indexPath) as! CallerCVCell
            //            cell.configCell(model: vm.arrHappeningNow[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension CallersView: CallTVCellDelegate, CallerCVCellDelegate {
    func didTapOnEndCaller(action: String) {
        if action == "END" {
            endCaller()
        } else {
            print("Declined")
        }
    }
    
    func didTapOnAddCaller(action: String) {
        if action == "ACCEPTED" {
            addCaller()
        } else {
            print("Declined")
        }
    }
}
