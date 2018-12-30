
import Foundation

class FundingModel : Codable{
    var category : Int?
    var currentAmount : Int?
    var goalAmount : Int?
    var idx : Int?
    var introduction : String?
    var limitAt : String?
    var mainPhoto : FundingPhotoModel?
    var title : String?
}
class FundingPhotoModel : Codable {
    var url : String?
    var createdAt : String?
}
