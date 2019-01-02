//
//  AdoptionCommentViewController.swift
//  rescat
//
//  Created by 김예은 on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class AdoptionCommentViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        //TODO: 더 나은 방법 생각해보기
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 64, right: 0.0)

    }

}

extension AdoptionCommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier, for: indexPath) as! CommentTableViewCell
        
        cell.nickNameLabel.text = "돌피"
        cell.dateLabel.text = "1/1"
        cell.timeLabel.text = "18:06"
        cell.contentLabel.text = "하기싫다하기싫다하기시러여놀고시퍼여완전완전놀고싶어여개발하기싫어요개귄찮아요러ㅏ이ㅓ라ㅣ어라미ㅓ라ㅣ얼;ㅑㅐㅈ더래ㅑㄷ저래더미ㅏ"
        
        return cell
    }
    
    
    
    
}
