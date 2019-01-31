import UIKit

class FundingCommentsViewController: UIViewController, APIServiceCallback, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    @IBOutlet var commentTableView : UITableView!
    var fundingComments = [FundingCommentModel]()
    @IBOutlet var commentTextField : UITextField!
    @IBOutlet var commentSendButton : UIButton!
    var fundingIdx = 0
    var keyboardStatus : Bool = false
    var request : FundingRequest!
    
    var constraintInitVal : CGFloat = 0
    var check = true
    var keyboardDismissGesture: UITapGestureRecognizer?
    @IBOutlet weak var commentBottomC: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(" --- funding comments ---- \(FundingDetailSegmentController.fundingIdx)")
        commentTableView.separatorStyle = .none
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTextField.delegate = self
        commentSendButton.addTarget(self, action: #selector(postCommentAction(_:)), for: .touchUpInside)
        
//        UIKeyboardType.

        commentTableView.layer.addBorder(edge: .top, color: UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0), thickness: 1.0)
        setKeyboardSetting()
        hideCommentView()
        commentTextField.layer.addBorder(edge: .top, color: #colorLiteral(red: 0.752874434, green: 0.7529841065, blue: 0.7528504729, alpha: 1), thickness: 1)
        
        commentTextField.addTarget(self, action: #selector(emptyCommentCheck), for: .editingChanged)

    }
    
    //MARK: 댓글 공백 체크 함수
    @objc func emptyCommentCheck() {
        
        if commentTextField.text == ""{
            commentTextField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            commentSendButton.setTitleColor(#colorLiteral(red: 0.5999459028, green: 0.6000347733, blue: 0.5999264717, alpha: 1), for: .normal)
            
        } else {
            commentTextField.backgroundColor = #colorLiteral(red: 0.9489366412, green: 0.9490728974, blue: 0.9489069581, alpha: 1)
            commentSendButton.setTitleColor(#colorLiteral(red: 0.9232344031, green: 0.5513463616, blue: 0.5515488386, alpha: 1), for: .normal)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        request = FundingRequest(self)
        request.requestFundingComments(FundingDetailSegmentController.fundingIdx)
        hideCommentView()
    }
    
    func hideCommentView() {
        let token = gsno(UserDefaults.standard.string(forKey: "token"))
        if token == "-1" {
            commentTextField.isHidden = true
            commentSendButton.isHidden = true
            commentBottomC.constant = -49
        } else {
            commentTextField.isHidden = false
            commentSendButton.isHidden = false
            commentBottomC.constant = 113
        }
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        if ( keyboardStatus ) {
//            keyboardStatus = false ;
//            UIView.animate(withDuration: 0.1) {
//                self.view.frame.origin.y += 166
//            }
//        }
//        textField.resignFirstResponder()
//        return true
//    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        if ( !keyboardStatus ) {
//            keyboardStatus = true ;
//            UIView.animate(withDuration: 0.1) {
//                self.view.frame.origin.y -= 166
//            }
//        }
//        textField.becomeFirstResponder()
//    }
    @objc func postCommentAction ( _ sender : UIButton!){
        
        if commentTextField.text == "" {
            self.simpleAlert(title: "error", message: "메시지를 입력하세요")
        }
        if ( keyboardStatus ) {
            keyboardStatus = false ; self.view.frame.origin.y += 260
            commentTextField.resignFirstResponder()
        }
        let comment = gsno(commentTextField.text)
        commentTextField.text = ""
        request.postFundingComment(comment, FundingDetailSegmentController.fundingIdx)
        
    }
   
    @objc func viewActionSheet( _ sender : UIButton!){
        //        guard let role = UserDefaults.standard.string(forKey: "role") else { return }
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }

        if ( token == "-1") {
            self.simpleAlert(title: "", message: "회원가입 후, 이용할 수 있어요.")
            return

        }
        guard let role = UserDefaults.standard.string(forKey: "role") else { return }
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        if ( gbno(fundingComments[sender.tag].isWriter) ) {
            actionSheet.addAction(UIAlertAction(title: "삭제", style: .default, handler: { result in
                self.request.requestFundingCommentDelete(FundingDetailSegmentController.fundingIdx, self.gino(self.fundingComments[sender.tag].idx))
                self.fundingComments.remove(at: sender.tag)
                self.commentTableView.reloadData()

            }))
        }
        actionSheet.addAction(UIAlertAction(title: "신고", style: .default, handler: { result in
            //doSomething
            self.simpleAlert(title: "", message: "해당 댓글을 신고하였습니다.")
        }))
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FundingCommentTableViewCell", for: indexPath) as! FundingCommentTableViewCell
//        print("--comment \(indexPath.row) \(gsno(fundingComments[indexPath.row].contents))")
        let comment = fundingComments[indexPath.row]
        cell.nicknameLabel.text = gsno(comment.nickname)
        cell.dateLabel.text = setDate(createdAt: gsno(comment.createdAt), format: "MM/dd HH:mm")
//        print("isWriter - \(comment.nickname) , \(comment.isWriter)")
        if gsno(comment.userRole) == "CARETAKER" {
            cell.caretakerImageView.image = UIImage(named: "iconCareTakerS")
        } else {
            cell.caretakerImageView.isHidden = true
        }
        cell.contentsLabel.text = gsno(comment.contents)
        if gbno(comment.isWriter) {
            cell.sendButton.setTitle("my", for: .normal)
        }
//        cell.tag = gino(comment.idx)
        cell.sendButton.tag = indexPath.row
        cell.sendButton.addTarget(self, action: #selector(viewActionSheet(_:)), for: .touchUpInside)
        return cell

    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fundingComments.count
    }
   
    
    
    func requestCallback(_ datas: Any, _ code: Int) {
        if code == APIServiceCode.FUNDING_COMMENTS {
            fundingComments = datas as![FundingCommentModel]
            print("funding comment count - \(fundingComments.count)")
            commentTableView.reloadData()
        } else if code == APIServiceCode.FUNDING_MY_COMMENT {
            let mycomment = datas as! FundingCommentModel
            fundingComments.append(mycomment)
            commentTableView.reloadData()
        } else if code == APIServiceCode.FUNDING_COMMENT_DELETE {
            self.commentTableView.reloadData()
        }
    }
    

}

//MARK: Keyboard Setting
extension FundingCommentsViewController {
    
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if check {
                constraintInitVal = commentBottomC.constant
                commentBottomC.constant += keyboardSize.height - 49
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




