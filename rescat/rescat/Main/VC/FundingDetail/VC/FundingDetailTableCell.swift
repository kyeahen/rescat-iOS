//
//  FundingDetailTableCell.swift
//  rescat
//
//  Created by jigeonho on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit
import AACarousel
class FundingDetailTableCell: UITableViewCell , AACarouselDelegate{
    func didSelectCarouselView(_ view: AACarousel, _ index: Int) {
//        imageView.kf.setImage(with: URL(string: url[index]))
    }
    
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        imageView.kf.setImage(with: URL(string: url[index]))
    }
    
    func downloadImages(_ url: String, _ index: Int) {
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: url)!, placeholder: nil, options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { ( downloadImage, error, cacheType, url) in
            
            guard let image = downloadImage else { return }
            self.slideImageView.images[index] = image
        })
        //        })

    }
    
    var photoArray = [String]()
    var titleArray = [String]()

    @IBOutlet var slideImageView : AACarousel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("FundingDetailTableCell")
        slideImageView.delegate = self

    }
    func reloadSlideImageView(_ photoAry : [String]){
        print("reload slide imageView")
        self.photoArray = photoAry
        slideImageView.setCarouselData(paths: photoArray,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: nil)
        //optional methods
        slideImageView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
        slideImageView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
