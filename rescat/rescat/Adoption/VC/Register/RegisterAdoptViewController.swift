//
//  RegisterAdoptViewController.swift
//  rescat
//
//  Created by 김예은 on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class RegisterAdoptViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var oneTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var breedTextField: UITextField!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var etcTextView: UITextView!
    
    var dataRecieved: String? {
        willSet {
            breedTextField.text = newValue
        }
    }
    
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    
    @IBOutlet var typeButton: [UIButton]!
    @IBOutlet var sexButton: [UIButton]!
    @IBOutlet var tnrButton: [UIButton]!
    @IBOutlet var vacButton: [UIButton]!
    var typeTag: Int = 0
    var sexTag: Int = 0
    var tnrTag: Int = 0
    var vacTag: Int = 0
    
    var typeCheck: Int = 0
    var sexCheck: Int = 0
    var tnrCheck: Int = 0
    var vacCheck: Int = 0
    
    var imageArr: [UIImage] = [UIImage(named: "icAddPhoto") ?? UIImage()]
    var imageNum: Int = 0
    let imagePicker : UIImagePickerController = UIImagePickerController()
    var imageUrl: [String] = [String]()
    var imageCheck: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackBtn()
        setCollectionView()
        setCustomView()
        
        //테이블 뷰 키보드 대응
        NotificationCenter.default.addObserver(self, selector: #selector(Care1ViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Care1ViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
    }
    
    //MARK: 키보드 대응 method
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        nameTextField.setTextField()
        oneTextView.setTextView()
        ageTextField.setTextField()
        breedTextField.setTextField()
        startTextField.setTextField()
        endTextField.setTextField()
        etcTextView.setTextView()
        
        //datePicker
        initDatePicker1()
        initDatePicker2()
        

    }
    
    //MARK: 컬렉션 뷰 세팅
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: UnwindSegue (breedVC -> resisterVC)
    @IBAction func unwindToRegister(sender: UIStoryboardSegue) {
        if let breedVC = sender.source as? SearchCatViewController {
            dataRecieved = breedVC.cat
        }
    }
    
    //MARK: 입양/임보 액션
    @IBAction func typeAction(_ sender: UIButton) {
        typeCheck = 1
        for  aButton: UIButton in typeButton! {
            
            typeTag = sender.tag
            if sender.tag == aButton.tag{
                aButton.isSelected = true;
                aButton.setImage(UIImage(named: "buttonRadioOn"), for: .normal)
            }else{
                aButton.isSelected = false;
                aButton.setImage(UIImage(named: "buttonRadioOff"), for: .normal)
            }
        }
    }
    
    //MARK: 성별 액션
    @IBAction func sexAction(_ sender: UIButton) {
        sexCheck = 1
        for  aButton: UIButton in sexButton! {
            
            typeTag = sender.tag
            if sender.tag == aButton.tag{
                aButton.isSelected = true;
                aButton.setImage(UIImage(named: "buttonRadioOn"), for: .normal)
            }else{
                aButton.isSelected = false;
                aButton.setImage(UIImage(named: "buttonRadioOff"), for: .normal)
            }
        }
    }
    
    //MARK: TNR 액션
    @IBAction func tnrAction(_ sender: UIButton) {
        tnrCheck = 1
        for  aButton: UIButton in tnrButton! {
            
            typeTag = sender.tag
            if sender.tag == aButton.tag{
                aButton.isSelected = true;
                aButton.setImage(UIImage(named: "buttonRadioOn"), for: .normal)
            }else{
                aButton.isSelected = false;
                aButton.setImage(UIImage(named: "buttonRadioOff"), for: .normal)
            }
        }
    }
    
    //MARK: 기초 예방 접종 여부 액션
    @IBAction func vacAction(_ sender: UIButton) {
        vacCheck = 1
        for  aButton: UIButton in vacButton! {
            
            typeTag = sender.tag
            if sender.tag == aButton.tag{
                aButton.isSelected = true;
                aButton.setImage(UIImage(named: "buttonRadioOn"), for: .normal)
            }else{
                aButton.isSelected = false;
                aButton.setImage(UIImage(named: "buttonRadioOff"), for: .normal)
            }
        }
    }
    
    //MARK: 등록할래요 액션
    @IBAction func saveAction(_ sender: UIButton) {
        if typeCheck == 0 || oneTextView.text == "" || nameTextField.text == "" || ageTextField.text == "" || sexCheck == 0 || breedTextField.text == "" || startTextField.text == "" || endTextField.text == "" || tnrCheck == 0 || vacCheck == 0 || etcTextView.text == "" {
            
            self.simpleAlert(title: "", message: "모든 항목을 입력해주세요.")
        }else {
            
            self.simpleAlertwithCustom(title: "", message: """
                글이 등록된 후에는 수정이 불가합니다.
                다시 한 번 확인해주세요 !
                """, ok: "작성 완료", cancel: "다시 확인") { (action) in
                    self.postRegisterAdopt()
            }
        }
    }
    
    

}

//MARK: CollectionView Extension
extension RegisterAdoptViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResisterImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ResisterImageCollectionViewCell
        
        if indexPath.row == 0 {
            cell.deleteButton.isHidden = true
        } else {
            cell.deleteButton.isHidden = false
        }
        
        cell.imageView.image = imageArr[indexPath.row]
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteImageFromButton(button:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openGallery()
    }
    
    //MARK: 이미지 삭제
    @objc func deleteImageFromButton(button: UIButton) {
        
        imageArr.remove(at: button.tag)
        imageNum -= 1
        collectionView.reloadData()
    }
    
}

//MARK: Networking Extension
extension RegisterAdoptViewController {
    
    
    //입양,임보 등록
    func postRegisterAdopt() {
        
        let name = gsno(nameTextField.text)
        let age = gsno(ageTextField.text)
        let breed = gsno(breedTextField.text)
        let content = gsno(oneTextView.text)
        let end = gsno(endTextField.text)
        let start = gsno(startTextField.text)
        let etc = gsno(etcTextView.text)
        
        //입양, 임보
        var adopt: Int = 0
        if typeTag == 0 {
            adopt = 0
        } else {
            adopt = 1
        }
        
        //성별
        var sex: Int = 0
        if sexTag == 0 {
            sex = 0
        } else {
            sex = 1
        }
        
        //tnr
        var tnr: Int = 0
        if tnrTag == 0 {
            tnr = 0
        } else {
            tnr = 1
        }
    
        //기초 예방 접종 여부
        var vac: String = ""
        switch vacTag {
        case 0:
            vac = vacMapping.know.rawValue
            break
            
        case 1:
            vac = vacMapping.none.rawValue
            break
        case 2:
            vac = vacMapping.one.rawValue
            break
        case 3:
            vac = vacMapping.two.rawValue
            break
        case 4:
            vac = vacMapping.three.rawValue
            break
        default:
            break
        }
        
    let params : [String : Any] = [  "age": age,
                                     "breed": breed,
                                     "contents": content,
                                     "endProtectionPeriod": end,
                                     "etc": etc,
                                     "name": name,
                                     "photoUrls": imageUrl,
                                     "sex": sex,
                                     "startProtectionPeriod": start,
                                     "tnr": tnr,
                                     "type": adopt,
                                     "vaccination": vac]
        
        RegisterAdoptService.shareInstance.postRegisterAdopt(params: params) {(result) in
            
            switch result {
            case .networkSuccess( _): //200
                self.navigationController?.popViewController(animated: true)
                break
                
            case .duplicated://409
                self.simpleAlert(title: "", message: "이미 신청한 글입니다.")
                self.navigationController?.popViewController(animated: true)
                break
                
            case .networkFail :
                self.networkErrorAlert()
                break
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요.")
                
                break
            }
        }
    }
    
    //사진 첨부
    func addImage(image : Data?){
        let params : [String : Any] = [:]
        var images : [String : Data]?
        
        if let image_ = image {
            images = [
                "data" : image_
            ]
        }
        
        PostImageService.shareInstance.addPhoto(params: params, image: images, completion: { [weak self] (result) in
            
            guard let `self` = self else { return }
            switch result {
                
            case .networkSuccess(let data):
                let data = data as? PhotoData
                if let img = data?.photoUrl {
                    self.imageUrl.append(img)
                    self.imageCheck = 1
                }
                break
                
            case .large :
                self.simpleAlert(title: "업로드 실패", message: "업로드 가능한 이미지 최대 크기는 10MB입니다.")
                break
                
            case .networkFail :
                self.networkErrorAlert()
                break
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        })
    }
    
}

//MARK: 이미지 첨부
extension RegisterAdoptViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Method
    @objc func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    // imagePickerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("사용자가 취소함")
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //        defer {
        //            self.dismiss(animated: true) {
        //                print("이미지 피커 사라짐")
        //            }
        //        }
        
        if let editedImage = info[.editedImage] as? UIImage {
            
            imageArr.append(editedImage)
            imageNum += 1
            let photo = editedImage.jpegData(compressionQuality: 0.3)
            addImage(image: photo) //이미지 추가
        } else if let selectedImage = info[.originalImage] as? UIImage as? UIImage{
            imageArr.append(selectedImage)
            imageNum += 1
            let photo = selectedImage.jpegData(compressionQuality: 0.3)
            addImage(image: photo)
        }
        
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
             self.collectionView.reloadData()
        }
    }
    
}


//MARK: DatePickerView Extension
extension RegisterAdoptViewController {
    
    func initDatePicker1(){
        
        datePicker.datePickerMode = .date
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let minDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        datePicker.minimumDate = minDate
        datePicker.date = minDate!
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: +10, to: Date())!
        
        let loc = Locale(identifier: "kr")
        datePicker.locale = loc
        
        setTextfieldView(textField: startTextField, selector: #selector(selectedDatePicker1), inputView: datePicker)
    }
    
    func initDatePicker2(){
        
        datePicker.datePickerMode = .date

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let minDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        datePicker.minimumDate = minDate
        datePicker.date = minDate!
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: +10, to: Date())!
        
        let loc = Locale(identifier: "kr")
        datePicker.locale = loc
        
        setTextfieldView(textField: endTextField, selector: #selector(selectedDatePicker2), inputView: datePicker)
    }
    
    func setTextfieldView(textField:UITextField, selector : Selector, inputView : Any){
        
        let bar = UIToolbar()
        bar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "확인", style: .done
            , target: self, action: selector)
        
        bar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = bar
        
        if let tempView = inputView as? UIView {
            textField.inputView = tempView
        }
        if let tempView = inputView as? UIControl {
            textField.inputView = tempView
        }
        
    }
    
    @objc func selectedDatePicker1(){
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateformatter.string(from: datePicker.date)
        
        startTextField.text = date
        
        view.endEditing(true)
    }
    
    @objc func selectedDatePicker2(){
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateformatter.string(from: datePicker.date)
        
        endTextField.text = date
        
        view.endEditing(true)
    }
    
}

//MARK: TableView Keyboard Setting Extension
extension RegisterAdoptViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            // For some reason adding inset in keyboardWillShow is animated by itself but removing is not, that's why we have to use animateWithDuration here
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        })
    }
}






