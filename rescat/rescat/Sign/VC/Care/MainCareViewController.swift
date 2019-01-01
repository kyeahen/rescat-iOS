//
//  MainCareViewController.swift
//  rescat
//
//  Created by 김예은 on 29/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class MainCareViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeVC(num: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: ChildViewController
    private lazy var IntroVC: IntroCareViewController = {
        var viewController = UIStoryboard(name: "Care", bundle: nil).instantiateViewController(withIdentifier: IntroCareViewController.reuseIdentifier) as! IntroCareViewController
        viewController.parentVC = self
        self.addChild(viewController)
        return viewController
    }()
    
    private lazy var care1VC: Care1ViewController = {
        var viewController = UIStoryboard(name: "Care", bundle: nil).instantiateViewController(withIdentifier: Care1ViewController.reuseIdentifier) as! Care1ViewController
        viewController.parentVC = self
        self.addChild(viewController)
        return viewController
    }()
    
    private lazy var care2VC: Care2ViewController = {
        var viewController = UIStoryboard(name: "Care", bundle: nil).instantiateViewController(withIdentifier: Care2ViewController.reuseIdentifier) as! Care2ViewController
            viewController.parentVC = self
        self.addChild(viewController)
        return viewController
    }()
    
    private lazy var care3VC: Care3ViewController = {
        var viewController = UIStoryboard(name: "Care", bundle: nil).instantiateViewController(withIdentifier: Care3ViewController.reuseIdentifier) as! Care3ViewController
        viewController.parentVC = self
        self.addChild(viewController)
        return viewController
    }()
    
    private lazy var finishVC: FinishCareViewController = {
        var viewController = UIStoryboard(name: "Care", bundle: nil).instantiateViewController(withIdentifier: FinishCareViewController.reuseIdentifier) as! FinishCareViewController
        self.addChild(viewController)
        return viewController
    }()
    
    func changeVC(num : Int){
        switch num {
            
        case 1:
            setBackBtn(color: #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1))
            
            UIView.animate(withDuration: 1.0) {
                self.progressView.setProgress(0.25, animated: true)
            }
            self.view.endEditing(true)
            add(asChildViewController: IntroVC, containerView: containerView)
            
            break
            
        case 2: //1단계
            setHiddenBackBtn()
            setLeftBarButtonItem1()
            
            UIView.animate(withDuration: 1.0) {
                self.progressView.setProgress(0.25, animated: true)
            }

            remove(asChildViewController: IntroVC, containerView: containerView)
            add(asChildViewController: care1VC, containerView: containerView)
            
            break
            
        case 3: //2단계
            setLeftBarButtonItem2()

            UIView.animate(withDuration: 1.0) {
                self.progressView.setProgress(0.5, animated: true)
            }
            
            remove(asChildViewController: care1VC, containerView: containerView)
            add(asChildViewController: care2VC, containerView: containerView)
            
            break
            
        case 4: //3단계
            setLeftBarButtonItem3()

            UIView.animate(withDuration: 1.0) {
                self.progressView.setProgress(0.75, animated: true)
            }
            
            remove(asChildViewController: care2VC, containerView: containerView)
            add(asChildViewController: care3VC, containerView: containerView)
            
            break
    
        case 5: //완료
            setLeftBarButtonItem4()

            UIView.animate(withDuration: 1.0) {
                self.progressView.setProgress(1.0, animated: true)
            }
            
            remove(asChildViewController: care3VC, containerView: containerView)
            add(asChildViewController: finishVC, containerView: containerView)
            
            break
            
        default:
            add(asChildViewController: IntroVC, containerView: containerView)
            break
        }
        
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: ChildViewController BackButton Setting
//TODO: 이미지 첨부
extension MainCareViewController {
    
    //MARK: care1 -> intro
    func setLeftBarButtonItem1() {
        
        let leftButtonItem = UIBarButtonItem.init(
            title: "back1",
            style: .plain,
            target: self,
            action: #selector(backAction1(sender:))
        )
        
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.4210352302, green: 0.298186332, blue: 0.2102506161, alpha: 1)
        self.navigationItem.leftBarButtonItem = leftButtonItem
    }
    
    @objc func backAction1(sender: UIBarButtonItem) {
        changeVC(num: 1)
    }
    
    //MARK: care2 -> care1
    func setLeftBarButtonItem2() {
        
        let leftButtonItem = UIBarButtonItem.init(
            title: "back2",
            style: .plain,
            target: self,
            action: #selector(backAction2(sender:))
        )
        
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.4210352302, green: 0.298186332, blue: 0.2102506161, alpha: 1)
        self.navigationItem.leftBarButtonItem = leftButtonItem
    }
    
    @objc func backAction2(sender: UIBarButtonItem) {
        changeVC(num: 2)
    }
    
    //MARK: care3 -> care2
    func setLeftBarButtonItem3() {
        
        let leftButtonItem = UIBarButtonItem.init(
            title: "back3",
            style: .plain,
            target: self,
            action: #selector(backAction3(sender:))
        )
        
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.4210352302, green: 0.298186332, blue: 0.2102506161, alpha: 1)
        self.navigationItem.leftBarButtonItem = leftButtonItem
    }
    
    @objc func backAction3(sender: UIBarButtonItem) {
        changeVC(num: 3)
    }
    
    //MARK: finish -> care3
    func setLeftBarButtonItem4() {
        
        let leftButtonItem = UIBarButtonItem.init(
            title: "back4",
            style: .plain,
            target: self,
            action: #selector(backAction4(sender:))
        )
        
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.4210352302, green: 0.298186332, blue: 0.2102506161, alpha: 1)
        self.navigationItem.leftBarButtonItem = leftButtonItem
    }
    
    @objc func backAction4(sender: UIBarButtonItem) {
        changeVC(num: 4)
    }
}
