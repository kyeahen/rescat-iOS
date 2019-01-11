import UIKit

class FundingCommentsViewController: UIViewController, APIServiceCallback, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    @IBOutlet var commentTableView : UITableView!
    var fundingComments = [FundingCommentModel]()
    @IBOutlet var commentTextField : UITextField!
    @IBOutlet var commentSendButton : UIButton!
    var fundingIdx = 0
    var keyboardStatus : Bool = false
    var request : FundingRequest!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(" --- funding comments ---- \(FundingDetailSegmentController.fundingIdx)")
        commentTableView.separatorStyle = .none
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTextField.delegate = self
        commentSendButton.addTarget(self, action: #selector(postCommentAction(_:)), for: .touchUpInside)
        
//        UIKeyboardType.

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        request = FundingRequest(self)
        request.requestFundingComments(FundingDetailSegmentController.fundingIdx)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        if ( keyboardStatus ) {
            keyboardStatus = false ;
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y += 260
            }
        }
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {

        print("keyboard height \(KeyboardService.keyboardHeight())")
        if ( !keyboardStatus ) {
            keyboardStatus = true ;
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y -= 260
            }
        }
        textField.becomeFirstResponder()
    }
    @objc func postCommentAction ( _ sender : UIButton!){
        
        if commentTextField.text == "" {
            self.simpleAlert(title: "error", message: "메시지를 입력하세요")
        }
        if ( keyboardStatus ) {
            keyboardStatus = false ; self.view.frame.origin.y += 270
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
