//
//  AdoptionCommentViewController.swift
//  rescat
//
//  Created by 김예은 on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class AdoptionCommentViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentBottomC: NSLayoutConstraint!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentButton: UIButton!
    
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
        setCustomView()
        getAdoptComment(_idx: idx)
        setKeyboardSetting()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.reloadData()

    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView(){
        
        let token = gsno(UserDefaults.standard.string(forKey: "token"))
        if token == "-1" {
            commentView.isHidden = true
            commentBottomC.constant = -49
        } else {
            commentView.isHidden = false
            commentBottomC.constant = 64
        }
        
        commentTextField.delegate = self
        commentView.layer.addBorder(edge: .top, color: #colorLiteral(red: 0.752874434, green: 0.7529841065, blue: 0.7528504729, alpha: 1), thickness: 1)
        commentTextField.addTarget(self, action: #selector(emptyCommentCheck), for: .editingChanged)
    }
    
    //MARK: 댓글 공백 체크 함수
    @objc func emptyCommentCheck() {
        
        if commentTextField.text == ""{
            commentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            commentButton.setTitleColor(#colorLiteral(red: 0.5999459028, green: 0.6000347733, blue: 0.5999264717, alpha: 1), for: .disabled)
            
        } else {
            commentView.backgroundColor = #colorLiteral(red: 0.9489366412, green: 0.9490728974, blue: 0.9489069581, alpha: 1)
            commentButton.setTitleColor(#colorLiteral(red: 0.9232344031, green: 0.5513463616, blue: 0.5515488386, alpha: 1), for: .normal)
        }
    }

    
    //MARK: 테이블 뷰 세팅
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 64, right: 0.0)
        
        // 테이블뷰의 스크롤 위에 새로고침이 되는 action을 추가
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
    }
    
    // refreshControl이 돌아갈 때 일어나는 액션
    @objc func startReloadTableView(_ sender: UIRefreshControl) {
        getAdoptComment(_idx: idx)
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    //MARK: 댓글 전송 액션
    @IBAction func commentAction(_ sender: UIButton) {
        enterComment()
        commentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        commentButton.setTitleColor(#colorLiteral(red: 0.5999459028, green: 0.6000347733, blue: 0.5999264717, alpha: 1), for: .normal)
    }
    
    //키보드 엔터 버튼으로 전송
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == commentTextField {
            enterComment()
        }
        return true
    }
    
    func enterComment() {
        if commentTextField.text != "" {
             postComment(idx: idx, contents: gsno(commentTextField.text))
        }
    }
    
    //MARK: 댓글 삭제 및 신고 액션
    func reportAction(c_id: Int, isWriter: Bool) {
        
        let token = gsno(UserDefaults.standard.string(forKey: "token"))
        
        if token == "-1" {
            self.simpleAlert(title: "", message: "로그인 후, 이용할 수 있어요.")
        } else {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            actionSheet.view.tintColor = #colorLiteral(red: 0.9400809407, green: 0.5585930943, blue: 0.5635480285, alpha: 1)
            
            if isWriter == true { //내가 작성한 댓글이면 삭제 가능
                actionSheet.addAction(UIAlertAction(title: "삭제", style: .default, handler: { result in
                    self.reportContent(idx: self.idx, c_id: c_id)
                    
                }))
            } else { //내가 작성한 댓글이 아니면 신고 가능
                actionSheet.addAction(UIAlertAction(title: "신고", style: .default, handler: { result in
                    self.warnContent(idx: self.idx, c_id: c_id)
                }))
            }

            actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            self.present(actionSheet, animated: true, completion: nil)
        }

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
        cell.timeLabel.text = setDate(createdAt: gsno(comments[indexPath.row].createdAt), format: "MM/dd  MHH:mm")
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
                
            case .accessDenied: //401
                self.simpleAlert(title: "", message: "로그인 후, 이용 가능합니다.")
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
                self.simpleAlert(title: "", message: "해당 댓글을 삭제하였습니다.")
                self.getAdoptComment(_idx: idx)
                break
                
            case .accessDenied :
                self.simpleAlert(title: "권한 없음", message: "해당 댓글을 삭제할 수 없습니다.")
                break
            
            case .networkFail :
                self.networkErrorAlert()
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        })
    }
    
    //댓글 신고
    func warnContent(idx: Int, c_id: Int) {
        
        CommentWarningService.shareInstance.postWarnComment(idx: idx, cId: c_id, params: [:], completion: { (result) in
            
            switch result {
            case .networkSuccess(_):
                self.simpleAlert(title: "", message: "해당 댓글을 신고하였습니다.")
                self.getAdoptComment(_idx: idx)
                break
                
            case .duplicated:
                self.simpleAlert(title: "", message: "이미 신고한 글입니다.")
                break
                
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



