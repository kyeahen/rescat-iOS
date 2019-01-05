import UIKit

class FundingCommentsViewController: UIViewController, APIServiceCallback, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet var commentTableView : UITableView!
    var fundingComments = [FundingCommentModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(" --- funding comments ---- \(FundingDetailSegmentController.fundingIdx)")
        commentTableView.delegate = self
        commentTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = FundingRequest(self)
        request.requestFundingComments(FundingDetailSegmentController.fundingIdx)
    }
   
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 100;
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FundingCommentTableViewCell", for: indexPath) as! FundingCommentTableViewCell
//        print("--comment \(indexPath.row) \(gsno(fundingComments[indexPath.row].contents))")
        let comment = fundingComments[indexPath.row]
        cell.nicknameLabel.text = gsno(comment.nickname)
        cell.dateLabel.text = gsno(comment.createdAt)
        if gsno(comment.userRole) == "CARETAKER" {
            cell.caretakerImageView.image = UIImage(named: "iconCareTakerS")
        } else {
            cell.caretakerImageView.isHidden = true
        }
        cell.contentsLabel.text = gsno(comment.contents)
        return cell

    }
   
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 2 {
//            return CGFloat(200)
//        } else {
//            return CGFloat(100)
//        }
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fundingComments.count
    }
   
    func requestCallback(_ datas: Any, _ code: Int) {
        if code == APIServiceCode.FUNDING_COMMENTS {
            fundingComments = datas as![FundingCommentModel]
            commentTableView.reloadData()
        } else { }
    }

}
