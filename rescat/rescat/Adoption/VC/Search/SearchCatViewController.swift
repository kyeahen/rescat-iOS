//
//  SearchCatViewController.swift
//  rescat
//
//  Created by 김예은 on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class SearchCatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var breeds: [BreedData] = [BreedData]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var breedData: [String] = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    var cat: String?
    var searchActive : Bool = false
    var filtered:[String] = []
    var num: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        setCustomView()
        setBackBtn()
        getCatList()
        
        searchTextField.addTarget(self, action: #selector(SearchCatViewController.textFieldDidChange(_:)),
                                  for: UIControl.Event.editingChanged)
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        searchTextField.setTextField(radius: 2, color: #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1))
    }
    
    //MARK: 테이블 뷰 세팅
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        let searchText  = textField.text

        filtered = breedData.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText ?? "", options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()

    }


    //MARK: 고양이 검색 액션
    @IBAction func searchAction(_ sender: UIButton) {
    }
    
}

//MAKK: TableView Extension
extension SearchCatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: SearchHeaderTableViewCell.reuseIdentifier) as! SearchHeaderTableViewCell
        
        headerCell.typeLabel.text = "고양이 종"
        
        return headerCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filtered.count
        } else {
            return breedData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchListTableViewCell.reuseIdentifier) as! SearchListTableViewCell

        if searchActive {
            cell.catLabel.text = filtered[indexPath.row]

        } else {
            cell.catLabel.text = breedData[indexPath.row]
        }
        
        return cell
    }
    
    //TODO: 고양이 선택 값 이전 뷰로 전달(unwind)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchActive {
            cat = filtered[indexPath.row]
            
        } else {
            cat = breedData[indexPath.row]
        }
        
        performSegue(withIdentifier: "unwindToRegister", sender: self)
        
    }
    

    
}

//MARK: Networking Extension
extension SearchCatViewController {
    
    //입양, 임보 리스트 조회
    func getCatList() {
        
        BreedService.shareInstance.getBreedList(completion: {
            (result) in
            
            switch result {
            case .networkSuccess(let data) :
                let breedData = data as? [BreedData]
                
                if let resResult = breedData {
                    self.breeds = resResult
                    
                    for i in 0..<self.breeds.count {
//                        let korean = self.breeds[i].korean
                        let english = self.breeds[i].english
//                        let name = "\(korean)(\(english))"
                        self.breedData.append(english)
                    }
                    
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
}
