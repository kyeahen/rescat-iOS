import Foundation
import UIKit
class SearchViewController : UIViewController , UISearchBarDelegate {
    
    @IBOutlet var initLabel : UILabel!
    @IBOutlet var searchBar : UISearchBar!
    @IBOutlet var searchListTableView : UITableView!
    var marker = [String]()
    var mapDatas = [MarkerModel]()
    var filteredMapDatas = [MarkerModel]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setBackBtn()
        searchBar.delegate = self
        searchListTableView.delegate = self
        searchListTableView.dataSource = self
        self.searchBar.delegate = self
        searchListTableView.separatorStyle = .none

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isHidden = true
//        searchBar.resignFirstResponder()
        initLabel.text = "최근 검색 기록"
        
    }
    
    // -----------------------------  UISearchBarDelegate function ----------------------------
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        detailViewHidden(true)
        initLabel.text = "검색 결과"
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
//        self.searchButton.isHidden = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("input \(searchText)")
        
//        mapDatas.filt
        filteredMapDatas = mapDatas.filter { (element) -> Bool in
            return gsno(element.name).contains(searchText)
        }
    searchListTableView.reloadData()

    }
}
extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMapDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.title.text = gsno(filteredMapDatas[indexPath.row].name)
        switch gino(filteredMapDatas[indexPath.row].category) {
        case 0:
            cell.type.text = "배식소"
        case 1:
            cell.type.text = "병원"
        case 2:
            cell.type.text = "고양이"
        default:
            cell.type.text = "고양이"

        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToFirstViewController(filteredMapDatas[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func goToFirstViewController( _ data : MarkerModel) {
        let vc = self.navigationController?.viewControllers.first as! MapViewController
        vc.focusMap = data
        self.navigationController?.popViewController(animated: true)
    }

 
    
}
