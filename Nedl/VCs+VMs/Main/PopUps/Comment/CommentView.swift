//
//  CommentView.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-03.
//

import UIKit
import Alamofire
import PusherSwift

protocol CommentViewDelegate {
    func didTapOnExitBtn(action: String)
}

class CommentView: UIView {
    
    static let instance = CommentView()
    var delegate : CommentViewDelegate?
    
    private let cellIdentifier = "CommentTVCell"
    
    let data = CommentData()
    let userUrl = DataStore.shared.getStreamUrl() ?? ""
    
    let MESSAGES_ENDPOINT = "https://live-commenting-ios.herokuapp.com/"
    var pusher: Pusher!
    var comments = [
        ["username": "John", "comment": "Amazing application nice!"],
        ["username": "Samuel", "comment": "How can I add a photo to my profile? This is longer than the previous comment."]
    ]
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var commentsSwitch: UISwitch!
    @IBOutlet weak var btnShareUrl: UIButton!
    @IBOutlet weak var lblListners: UILabel!
    @IBOutlet weak var lblHayCount: UILabel!
    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var commentSendBtn: UIButton!
    @IBOutlet weak var commentsTableView: UITableView!  {
        didSet {
            commentsTableView.delegate = self
            commentsTableView.dataSource = self
        }
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("CommentView", owner: self, options: nil)
        data.getComments()
        commomInit()
        listenForNewComments()
        addComposeButtonToNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func didTapOnSendComment(_ sender: UIButton) {
        if (commentTF?.hasText)! {
            self.postComment(comment: (commentTF?.text)!)
        }
        
    }
    
    private func listenForNewComments() -> Void {
        pusher = Pusher(key: "a924587349347e93fbc5")
        let channel = pusher.subscribe("nedl-sandbox" + userUrl ) //  presence-channelName(streamurl)
        let _ = channel.bind(eventName: "client-message", eventCallback: { (data: Any?) -> Void in  // for listning message, client-message
            
            // for sending - no
            if let data = data as? [String: AnyObject] {
                let comment = ["username":"Anonymous", "comment": (data["text"] as! String)]
                
                self.comments.insert(comment, at: 0)
                
                self.commentsTableView.beginUpdates()
                self.commentsTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                self.commentsTableView.endUpdates()
            }
        })
        pusher.connect()
    }
    
    private func addComposeButtonToNavigationBar() -> Void {
        let button = UIBarButtonItem(barButtonSystemItem: .compose,
                                     target: self,
                                     action: #selector(buttonTapped))
//        navigationItem.setRightBarButton(button, animated: false)
    }
    
    @objc func buttonTapped() -> Void {
        let alert = UIAlertController(title: "Post",
                                      message: "Enter a comment and see it inserted in real time using Pusher",
                                      preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = nil
            textField.placeholder = "Enter comment"
        }
        
        alert.addAction(UIAlertAction(title: "Add Comment", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            
            if (textField?.hasText)! {
                self.postComment(comment: (textField?.text)!)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
//        self.present(alert, animated: true, completion: nil)
    }
    
    private func postComment(comment: String) -> Void {
        AF.request(MESSAGES_ENDPOINT, method: .post, parameters: ["comment": comment])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Posted successfully")
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    private func commomInit() {
        
        // Parentview Properties
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        commentTF.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.1803921569, blue: 0.2, alpha: 1)
        commentTF.layer.borderWidth = 1
        commentTF.layer.cornerRadius = 5
        
        btnShareUrl.buttonPropertiesThree()
        registerCell()
    }
    
    func showCommentView(from vc: UIViewController) {
        self.delegate = vc as? CommentViewDelegate
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    func registerCell() {
        self.commentsTableView.reloadData()
        self.commentsTableView.register(UINib(nibName: "CommentTVCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    @IBAction func didTapOnClose(_ sender: UIButton) {
        delegate?.didTapOnExitBtn(action: "Exit")
        parentView.removeFromSuperview()
    }
}

extension CommentView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        data.arrComment.count
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTVCell", for: indexPath) as! CommentTVCell

                cell.lblName?.text = "? " + (comments[indexPath.row]["username"] ?? "Anonymous")
                cell.lblComment?.text  = comments[indexPath.row]["comment"]

                return cell
        
        
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTVCell", for: indexPath) as? CommentTVCell {
//            cell.configCell(model: data.arrComment[indexPath.row])
//            return cell
//        }
//        return UITableViewCell()
    }
}
