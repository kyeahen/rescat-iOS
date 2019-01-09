import UIKit
class FundingDetailModel : Codable{
    
    var account : String?
    var bankName : String?
    var category : Int?
    var contents : String?
    var createdAt : String?
    var currentAmount : Int?
    var goalAmount : Int?
    var idx : Int?
    var introduction : String?
    var isConfirmed : Int?
    var limitAt : String?
    var mainRegion : String?
    var nickname : String?
    var title : String?
    var photos : [FundingPhotoModel]?
    var certifications : [FundingPhotoModel]?

}
class FundingDetailPhoto : Codable {
    var certification : Bool?
    var createdAt : String?
    var url : String?
}
