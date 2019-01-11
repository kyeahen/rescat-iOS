import Foundation
import UIKit
class SearchViewController : UIViewController , UISearchBarDelegate {
    
    @IBOutlet var searchBar : UISearchBar!
    @IBOutlet var searchListTableView : UITableView!
    var marker = [String]()
    var mapDatas = [MarkerModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchListTableView.delegate = self
        searchListTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isHidden = true
//        searchBar.resignFirstResponder()
        
    }
    
    // -----------------------------  UISearchBarDelegate function ----------------------------
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        detailViewHidden(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
//        self.searchButton.isHidden = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("input \(searchText)")
    }
}
extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.title.text = "title"
        cell.type.text = "고양이"
        return cell
    }
    
    
}
