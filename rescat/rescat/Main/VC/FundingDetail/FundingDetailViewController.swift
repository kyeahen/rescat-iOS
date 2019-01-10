import UIKit
import AACarousel
class FundingDetailViewController : UIViewController , UITableViewDelegate , UITableViewDataSource, APIServiceCallback{
    
    
    var fundingContent : FundingDetailModel!
    var resultTableCellCnt : Int = 0
    @IBOutlet var fundingButton : UIButton!
    @IBOutlet var testTable : UITableView!
    
    override func viewDidLoad() {
        print("------ funding detail contents view controller ------ ")
        super.viewDidLoad()
        
        self.setBackBtn()
        
        
        testTable.delegate = self
        testTable.dataSource = self
        testTable.separatorStyle = .none
        let nib1 = UINib(nibName: "FundingDetailTableCell", bundle: nil)
        testTable.register(nib1, forCellReuseIdentifier: "FundingDetailTableCell")
        let nib2 = UINib(nibName: "FundingDetailContentTableCell", bundle: nil)
        testTable.register(nib2, forCellReuseIdentifier: "FundingDetailContentTableCell")
        let nib3 = UINib(nibName: "FundingDetailBottomTableCell", bundle: nil)
        testTable.register(nib3, forCellReuseIdentifier: "FundingDetailBottomTableCell")
        fundingButton.addTarget(self, action: #selector(fundingAction(_:)), for: .touchUpInside)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = FundingRequest(self)
        request.requestFundingDetail(FundingDetailSegmentController.fundingIdx)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultTableCellCnt
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(370)
        } else if indexPath.row == 1{
            if gino(fundingContent.category) == 0 {
                return CGFloat(355+178)
            } else {
                return CGFloat(355)
            }
        } else {
            return CGFloat(227)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FundingDetailTableCell", for: indexPath) as! FundingDetailTableCell
            cell.titleLabel.text = gsno(fundingContent.title)
            cell.introductionLabel.text = gsno(fundingContent.introduction)
            
            guard let photoArray = fundingContent.photos else { return cell }
            var photos = [String]()
            for i in 0..<photoArray.count {
                photos.append(gsno(photoArray[i].url))
            }
            print("photo count \(photos.count)")
            cell.reloadSlideImageView(photos)
            if gino(fundingContent.category) == 0 {
                cell.categoryImageView.image = UIImage(named: "cardLableSupport")

            } else {
                cell.categoryImageView.image = UIImage(named: "cardLableProject")
            }
            cell.selectionStyle = .none
            return cell
        } else if ( indexPath.row == 1) {
           
            if gino(fundingContent.category) == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "FundingDetailContentTableCell", for: indexPath) as! FundingDetailContentTableCell
                cell.contentsLabel.text = gsno(fundingContent.contents)
                cell.currentAmountLabel.text = "\(gino(fundingContent.currentAmount).getMoney())원"
                let percentage = Float(gino(fundingContent.currentAmount)) / Float(gino(fundingContent.goalAmount))
                cell.percentageLabel.text = "\(Int(percentage*100))%"
                cell.percentageView.drawPercentage(Double(percentage), UIColor.rescatWhite(), UIColor.rescatPink())
//                cell.dueDateLabel.text = gsno(fundingContent.limitAt)
                cell.selectionStyle = .none
                let imageArray : [UIImageView] = [cell.image1,cell.image2,cell.image3]
                guard let imageCnt = fundingContent.certifications else { return cell }
                for i in 0..<imageCnt.count{
                    guard let url = imageCnt[i].url else { return cell }
                    imageArray[i].kf.setImage(with: URL(string:url))
                }
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "FundingDetailContentTableCell", for: indexPath) as! FundingDetailContentTableCell
                cell.contentsLabel.text = gsno(fundingContent.contents)
                cell.currentAmountLabel.text = "\(gino(fundingContent.currentAmount).getMoney())원"
                let percentage =  Float(gino(fundingContent.currentAmount)) / Float(gino(fundingContent.goalAmount))
                cell.percentageLabel.text = "\(Int(ceil(percentage*100)))%"
                cell.percentageView.drawPercentage(Double(percentage), UIColor.rescatWhite(), UIColor.rescatPink())
//                DateFormatter
//                cell.dueDateLabel.text = fundingContent.limitAt
              
                cell.label1.isHidden = true; cell.label2.isHidden = true
                cell.image1.isHidden = true; cell.image2.isHidden = true; cell.image3.isHidden = true
                cell.selectionStyle = .none
                return cell
                
            }
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FundingDetailBottomTableCell", for: indexPath) as! FundingDetailBottomTableCell
//            cell.title.text = "asd"
//            cell.adoptionButton.addTarget(self, action: #selector(fundingAction(_:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell

        }
    }
    @objc func fundingAction ( _ sender : UIButton!){
        
        guard let role = UserDefaults.standard.string(forKey: "role") else { return }
        
        if role == "NOT" {
            self.simpleAlert(title: "", message: "회원만 이용할 수 있는 메뉴입니다.")
            return
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "FundingSupportViewController") as! FundingSupportViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
    func requestCallback(_ datas: Any, _ code: Int) {
        if code == APIServiceCode.FUNDING_DETAIL {
            fundingContent = datas as! FundingDetailModel
            resultTableCellCnt = 3
            testTable.reloadData()
        } else { }
    }
}
