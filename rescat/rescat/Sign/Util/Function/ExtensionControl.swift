//
//  ExtensionControl.swift
//  rescat
//
//  Created by 김예은 on 26/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    
    //스토리보드 idetifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    //확인 팝업
    func simpleAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0.9400809407, green: 0.5585930943, blue: 0.5635480285, alpha: 1)
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    //네트워크 에러 팝업
    func networkErrorAlert() {
        
        let alert = UIAlertController(title: "네트워크 오류", message: "네트워크 상태를 확인해주세요", preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0.9108466506, green: 0.5437278748, blue: 0.5438123941, alpha: 1)
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    //확인, 취소 팝업 - 버튼 커스텀
    func simpleAlertwithCustom(title: String, message: String, ok: String, cancel: String, okHandler : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0.9108466506, green: 0.5437278748, blue: 0.5438123941, alpha: 1)
        let okAction = UIAlertAction(title: ok,style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: cancel,style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    //확인, 취소 팝업
    func simpleAlertwithHandler(title: String, message: String, okHandler : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0.9108466506, green: 0.5437278748, blue: 0.5438123941, alpha: 1)
        let okAction = UIAlertAction(title: "확인",style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: "취소",style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    //네비게이션 바 투명하게 하는 함수
    func setNavigationBar() {
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
    
    //네비게이션바 타이틀 left
    func setNaviTitle(name: String) {
        let label = UILabel()
        label.text = name
        label.font = UIFont(name: AppleSDGothicNeo.Bold.rawValue, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = #colorLiteral(red: 0.1411602199, green: 0.141186893, blue: 0.1411544085, alpha: 1)
        label.textAlignment = .left
        self.navigationItem.titleView = label
        
//        label.snp.makeConstraints ({
//            (make) in
//            make.left.equalToSuperview().offset(offset)
//        })
        
//        if let navigationBar = navigationController?.navigationBar {
//
//            label.widthAnchor.constraint(equalTo: navigationBar.widthAnchor, constant: -40).isActive = true
//        }
    }
    
    //커스텀 백버튼 설정
    func setBackBtn(){

        let backBTN = UIBarButtonItem(image: UIImage(named: "icBack"), //백버튼 이미지 파일 이름에 맞게 변경해주세요.
            style: .plain,
            target: self,
            action: #selector(self.pop))

        navigationItem.leftBarButtonItem = backBTN
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }

    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //백버튼 숨기기
    func setHiddenBackBtn() {
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton

    }
    
    //커스텀 팝업 띄우기 애니메이션
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    //커스텀 팝업 끄기 애니메이션
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
        
    //ContainerView 메소드
    func add(asChildViewController viewController: UIViewController, containerView: UIView) {
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    func remove(asChildViewController viewController: UIViewController, containerView: UIView) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
        
    }
    
    //데이트 변환
    func setDate(createdAt: String , format: String) -> String{
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.timeZone = TimeZone(abbreviation: "KST") //Set timezone that you want
        dateFormatterGet.locale = NSLocale.current
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        
        guard let date = dateFormatterGet.date(from: createdAt) else {return ""}

        return dateFormatterPrint.string(from: date)
    }
    
    //커스텀 토스트
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: AppleSDGothicNeo.Medium.rawValue, size: 14.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    //1시간 전
    func setHours(start: String) -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let day  = dateFormatter.date(from: start)! //문자열을 date포맷으로 변경
        let interval = NSDate().timeIntervalSince(day)
        let hour = Int(interval / 3600)
        let minute = Int(interval / 60) % 60
        
        if hour <= 24 {
            if hour < 1 {
                return "\(minute)분 전"
            } else {
                return "\(hour)시간 전"
            }
        } else {
            return setDate(createdAt: start, format: "MM/dd  HH:ss")
        }

    }
    
    //100일 남음
    func setDday(start: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let day = dateFormatter.date(from: start)! //문자열을 date포맷으로 변경
        let interval = NSDate().timeIntervalSince(day)
        let days = Int(interval / 86400)
        
        if days < 0 {
            return "\(days.magnitude)일 남음"
        } else {
            return "마감"
        }

    }
    
    //키보드 대응
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }


}

extension UIView {
    
    //뷰 라운드 처리 설정
    func makeRounded(cornerRadius : CGFloat?){
        if let cornerRadius_ = cornerRadius {
            self.layer.cornerRadius = cornerRadius_
        }  else {
            self.layer.cornerRadius = self.layer.frame.height/2
        }
        self.layer.masksToBounds = true
    }
    
    //뷰 그림자 설정
    //color: 색상, opacity: 그림자 투명도, offset: 그림자 위치, radius: 그림자 크기
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIImageView {
    
    //이미지뷰 동그랗게 설정
    func circleImageView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
}

extension UIButton {
    
    //MARK: 버튼 라벨 밑줄
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

extension UITextField {
    
    func setTextField() {
        self.layer.borderColor = #colorLiteral(red: 0.9232344031, green: 0.5513463616, blue: 0.5515488386, alpha: 1)
        self.layer.borderWidth = 1
        self.makeRounded(cornerRadius: 8)
    }
    
    func setTextField(radius: CGFloat, color: CGColor) {
        self.layer.borderColor = color
        self.layer.borderWidth = 1
        self.makeRounded(cornerRadius: radius)
    }
    
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

extension UITextView {
    
    func setTextView() {
        self.layer.borderColor = #colorLiteral(red: 0.9232344031, green: 0.5513463616, blue: 0.5515488386, alpha: 1)
        self.layer.borderWidth = 1
        self.makeRounded(cornerRadius: 8)
        resetTintColor()
    }
    
    func resetTintColor(){
        let color = tintColor
        tintColor = .clear
        tintColor = #colorLiteral(red: 0.9232344031, green: 0.5513463616, blue: 0.5515488386, alpha: 1)
    }
    
    //텍스트뷰 스크롤 상단으로 초기화
    //따로 메소드를 호출하지 않아도 이 메소드가 extension에 선언된 것만으로 적용이 됩니다.
    override open func draw(_ rect: CGRect)
    {
        super.draw(rect)
        setContentOffset(CGPoint.zero, animated: false)
    }
    
}

extension CALayer {
    
    //뷰 테두리 설정
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer();
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0, y:self.frame.height - thickness, width:self.frame.width, height:thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x:self.frame.width - thickness, y: 0, width: thickness, height:self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
}

extension Int {
    
    //숫자 콤마
    private static var commaFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    internal var commaRepresentation: String {
        return Int.commaFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
