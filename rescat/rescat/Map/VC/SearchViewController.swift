import Foundation
import UIKit
class SearchViewController : UIViewController , UISearchBarDelegate{
    
    @IBOutlet var searchBar : UISearchBar!
    @IBOutlet var searchListTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        searchBar.resignFirstResponder()
        
    }
    @IBAction func backAction(_ sender : UIButton!){
        self.navigationController?.popViewController(animated: true)
    }
    // -----------------------------  UISearchBarDelegate function ----------------------------
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        detailViewHidden(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
//        self.searchButton.isHidden = true
    }
}
