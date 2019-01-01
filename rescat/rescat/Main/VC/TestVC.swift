import UIKit
class TestVC : UIViewController , UITableViewDelegate , UITableViewDataSource, APIServiceCallback{
    
    var comments = [FundingCommentModel]()
    
    @IBOutlet var testTable : UITableView!
    
    override func viewDidLoad() {
        print("------ funding comment view controller ------ ")
        super.viewDidLoad()
        testTable.delegate = self
        testTable.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = FundingRequest(self)
        request.requestFundingComments(FundingDetailViewController.fundingIdx)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestVCCell", for: indexPath) as! TestVCCell
        cell.title.text = "asd"
        return cell
    }
    func requestCallback(_ datas: Any, _ code: Int) {
        if code == APIServiceCode.FUNDING_COMMENTS {
            comments = datas as! [FundingCommentModel]
            testTable.reloadData()
        } else { }
    }
}
