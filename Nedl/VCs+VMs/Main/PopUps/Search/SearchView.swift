//
//  SearchView.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-03.
//

import UIKit

protocol SearchViewDelegate {
    func didTapOnExitBtn(action: String)
}

class SearchView: UIView {
    
    static let instance = SearchView()
    var delegate : SearchViewDelegate?
    
    private let cellIdentifier = "SearchTVCell"

    let data = SearchData()
    
    @IBOutlet var parentview: UIView!
    @IBOutlet weak var popUpview: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
        }
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("SearchView", owner: self, options: nil)
        data.getSearch()
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commomInit() {
        
        // Parentview Properties
        parentview.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentview.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        searchTF.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.1803921569, blue: 0.2, alpha: 1)
        searchTF.layer.borderWidth = 1
        searchTF.layer.cornerRadius = 5
        registerCell()
    }
    
    func showSearchView(from vc: UIViewController) {
        self.delegate = vc as? SearchViewDelegate
        UIApplication.shared.keyWindow?.addSubview(parentview)
    }
    
    func registerCell() {
        self.searchTableView.reloadData()
        self.searchTableView.register(UINib(nibName: "SearchTVCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    
    @IBAction func didTapOnCloseBtn(_ sender: UIButton) {
        delegate?.didTapOnExitBtn(action: "Exit")
        parentview.removeFromSuperview()
    }
}

extension SearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.arrSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTVCell", for: indexPath) as? SearchTVCell {
            cell.configCell(model: data.arrSearchList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
