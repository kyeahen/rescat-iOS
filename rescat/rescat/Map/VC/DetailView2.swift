import UIKit
class DetailView2 : UIView{
    
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var propertyLabel : UITextView!
    @IBOutlet var modifyButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    private func commonInit(){
//        Bundle.main.l
        let view = Bundle.main.loadNibNamed("DetailView2", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
