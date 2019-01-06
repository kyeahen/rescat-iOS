//
//  AdoptionCommentViewController.swift
//  rescat
//
//  Created by 김예은 on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class AdoptionCommentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentBottomC: NSLayoutConstraint!
    @IBOutlet weak var commentTextField: UITextField!
    
    var comments: [AdoptCommentData] = [AdoptCommentData]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var idx: Int = 0
    var tag: Int = 0
    
    var constraintInitVal : CGFloat = 0
    var check = true
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        getAdoptComment(_idx: idx)
        setKeyboardSetting()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    //MARK: 테이블 뷰 세팅
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        //TODO: 더 나은 방법 생각해보기
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 64, right: 0.0)
    }
    
    //MARK: 댓글 전송 액션
    @IBAction func commentAction(_ sender: UIButton) {
        postComment(idx: idx, contents: gsno(commentTextField.text))
    }
    
    //MARK: 댓글 삭제 및 신고 액션
    func reportAction(c_id: Int) {
        
        let actionSheet = UIAlertController(title: "", message: "기타", preferredStyle: .actionSheet)
        actionSheet.view.tintColor = #colorLiteral(red: 0.9400809407, green: 0.5585930943, blue: 0.5635480285, alpha: 1)
        actionSheet.addAction(UIAlertAction(title: "삭제", style: .default, handler: { result in
            self.reportContent(idx: self.idx, c_id: c_id)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "신고", style: .default, handler: { result in
            
            
        }))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)

    }

    
}

//MARK: TableView Extension
extension AdoptionCommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    //TODO: 케어테이커이면 이미지 첨부 예외처리, 디데이 계산
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier, for: indexPath) as! CommentTableViewCell
        
        let role = comments[indexPath.row].userRole
        if role == careMapping.care.rawValue {
            cell.iconImageView.isHidden = false
            cell.iconImageView.image = UIImage(named: "iconCareTakerS")
        } else {
            cell.iconImageView.isHidden = true
        }
        
        cell.nickNameLabel.text = comments[indexPath.row].nickname
        cell.timeLabel.text = setDate(createdAt: comments[indexPath.row].createdAt, format: "MM/dd   HH:mm")
        cell.contentLabel.text = comments[indexPath.row].contents
        
        cell.configure(data: comments[indexPath.row])
        cell.reportHandler = reportAction
        
        
        return cell
    }

}

//MARK: Networking Extension
extension AdoptionCommentViewController {
    
    //댓글 조회
    func getAdoptComment(_idx: Int) {
        
        AdoptCommentService.shareInstance.getAdoptComment(idx: _idx, completion: {
            (result) in
            
            switch result {
            case .networkSuccess(let data) :
                let commentData = data as? [AdoptCommentData]
                
                if let resResult = commentData {
                    self.comments = resResult
                    self.tableView.reloadData()
                }
                break
                
            case .networkFail :
                self.networkErrorAlert()
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        })
    }
    
    //댓글 전송
    func postComment(idx: Int, contents: String) {
        
        let params : [String : Any] = ["contents": contents,
                                       "photoUrl": ""]
        
        PostCommentService.shareInstance.postComment(idx: idx, params: params) {(result) in
            
            switch result {
            case .networkSuccess(_ ): //201
                self.getAdoptComment(_idx: idx)
                self.commentTextField.text = ""

                break
                
            case .networkFail :
                self.networkErrorAlert()
                break
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요.")
                break
            }
        }
    }
    
    //댓글 삭제
    func reportContent(idx: Int, c_id: Int) {
        
        DeleteCommentService.shareInstance.deleteComment(idx: idx, c_id: c_id, completion: { (result) in

            switch result {
            case .networkSuccess(_):
                self.simpleAlert(title: "성공", message: "해당 댓글을 삭제하였습니다.")
                self.getAdoptComment(_idx: idx)
                break
                
            case .accessDenied :
                self.simpleAlert(title: "권한 없음", message: "해당 댓글을 삭제할 수 없습니다.")
                
            case .networkFail :
                self.networkErrorAlert()
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        })
    }
    
    
}

//MARK: Keyboard Setting
extension AdoptionCommentViewController {
    
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if check {
                constraintInitVal = commentBottomC.constant
                commentBottomC.constant += keyboardSize.height
                self.view.layoutIfNeeded()
                check = false
            }
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            commentBottomC.constant = constraintInitVal
            self.view.layoutIfNeeded()
            check = true
        }
    }
    
    func adjustKeyboardDismissGesture(isKeyboardVisible: Bool) {
        if isKeyboardVisible {
            if keyboardDismissGesture == nil {
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
                view.addGestureRecognizer(keyboardDismissGesture!)
            }
        } else {
            if keyboardDismissGesture != nil {
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    
    @objc func tapBackground() {
        self.view.endEditing(true)
    }
}



