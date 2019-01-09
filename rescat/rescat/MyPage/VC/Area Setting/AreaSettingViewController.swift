//
//  AreaSettingViewController.swift
//  rescat
//
//  Created by 김예은 on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class AreaSettingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var areaArr: [String] = [String]() { //지역 스트링 배열
        didSet {
            collectionView.reloadData()
        }
    }
    
    var myAreas : [MyPageRegions] = [MyPageRegions]() { //서버에서 받는 배열
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackBtn()
        setCollectionView()
        getMyAreaList()
        setupPressGestureRecognizer()
        
    }
    
    //MARK: 컬렉션뷰 세팅
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: drag&drop
    func setupPressGestureRecognizer() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        longPressGesture.minimumPressDuration = 0.3

        collectionView.addGestureRecognizer(longPressGesture)
    }

    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {

        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)

        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))

        case .ended:
            collectionView.endInteractiveMovement()

        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    //MARK: 완료 버튼 설정
    func setRightBarButtonItem() {
        let rightButtonItem = UIBarButtonItem.init(
            title: "완료",
            style: .done,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor =  #colorLiteral(red: 0.9108466506, green: 0.5437278748, blue: 0.5438123941, alpha: 1)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: AppleSDGothicNeo.Bold.rawValue, size: 16)], for: .normal)
    }
    
    //MARK: 완료 액션
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        //unwind
    }
    
    //MARK: UnwindSegue (MyPageAreaVC -> AreaSettingVC)
    @IBAction func unwindToArea(sender: UIStoryboardSegue) {
        if let areaVC = sender.source as? MyPageAddAreaViewController {
            getMyAreaList()
            collectionView.reloadData()
        }
    }

}

//MARK: CollectionView Extension
extension AreaSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return areaArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        
        let areaCnt = areaArr.count
        let index = areaCnt - (areaCnt - myAreas.count)
        
        if indexPath.row < index {
            return true
        } else if myAreas.count == 1 {
            return false
        } else {
            return false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

            let item = myAreas.remove(at: sourceIndexPath.item)
            myAreas.insert(item, at: destinationIndexPath.item)
            print(myAreas)
            print(areaArr)

            //여기부분이 셀 색 안바뀌는 경우 예외처리한 것
            //마지막 셀을 첫번째 위치로 가져올 경우만 두번째 셀이 색이 안바껴서 직접 reloadItems를 호출했음
            if sourceIndexPath.item == 2 && destinationIndexPath.item == 0 {
                collectionView.reloadItems(at: [IndexPath(item: 1, section: 0)])
            }
            collectionView.reloadItems(at: [sourceIndexPath])

    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageAreaCollectionViewCell.reuseIdentifier, for: indexPath) as! MyPageAreaCollectionViewCell

        if indexPath.row == 0 {
            cell.backView.backgroundColor = #colorLiteral(red: 0.918808341, green: 0.5516380668, blue: 0.5516873598, alpha: 1)
        } else {
            cell.backView.backgroundColor = #colorLiteral(red: 0.7313321233, green: 0.5840324163, blue: 0.4932969213, alpha: 1)
        }
        
        if areaArr[indexPath.row] == "" {
            cell.backView.isHidden = true
        } else {
            cell.areaLabel.text = areaArr[indexPath.row]
            cell.backView.isHidden = false
        }

        cell.backView.makeRounded(cornerRadius: 17.5)
        cell.configure(add: areaArr[indexPath.row], cnt: myAreas.count)
        cell.addHandler = addAction
        cell.delHanler = delAction
        
        return cell
    }
    
    //지역 추가 뷰로 이동
    func addAction() {
        let addVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "AddAreaNaviVC")
        
        self.present(addVC, animated: true, completion: nil)
    }
    
    //MARK: 지역 삭제 액션
    func delAction(address: String, count: Int) {
        //지역 삭제 api
        
        if count == 1 {
            self.simpleAlert(title: "", message:
                """
                케어테이커로 활동하는 지역은
                최소 1개 이상이어야 합니다.
                """
            )
        } else {
            deleteArea(_address: address)
            print(address)
        }
    }
    
    
}

//MARK: Networking Extension
extension AreaSettingViewController {
    
    //유저 지역 조회
    func getMyAreaList() {
        
        GetMyPageAreaService.shareInstance.getMyAreaInit(completion: {
            (result) in
            
            switch result {
            case .networkSuccess(let data) :
                let areaData = data as? [MyPageRegions]
                self.areaArr.removeAll()
                if let resResult = areaData {
                    self.myAreas = resResult
                    
                    let newArea: Int = 3 - resResult.count
                    
                    if resResult.count != 0 {
                        for i in 0..<resResult.count {
                            let name = self.myAreas[i].name
                            self.areaArr.append(name)
                        }

                        
                        for i in 0..<newArea {
                            self.areaArr.append("")
                        }
                        print(self.areaArr)
                    }
                }
                break
                
            case .accessDenied :
                self.simpleAlert(title: "", message: "로그인 후, 이용할 수 있습니다.")
                break
                
            case .networkFail :
                self.networkErrorAlert()
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        })
    }
    
    //FIXME : 수정!!
    //지역 삭제
    func deleteArea(_address: String) {
        
        DeleteMyPageAreaService.shareInstance.deleteArea(address: _address, completion: { (result) in

            switch result {
            case .networkSuccess(_):
                self.simpleAlert(title: "", message: "해당 지역을 성공적으로 삭제하였습니다.")
                self.getMyAreaList()
                break

            case .accessDenied :
                self.simpleAlert(title: "", message: "해당 지역을 삭제할 수 없습니다.")

            case .networkFail :
                self.networkErrorAlert()

            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        })
    }
    
}
