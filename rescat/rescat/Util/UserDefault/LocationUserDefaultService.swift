import Foundation
class LocationUserDefaultService {
    
    static func setNewLocation( _ address : String, lat : Double, long : Double) {
        // 새로운 지역 등록
        // 없으면 새롭게 등록
        let d = UserDefaults.standard.object(forKey: "myplaces")
//        guard let places = d as! NSDictionary else { return }
        
        // 3개가 넘어가면 error
    }
    static func setPrimaryLocation( _ address : String, lat : Double, long : Double ) {
        
        // 0번째로 바꿈
    }
    static func getMyLocationList() {
        // 0번째 primary
        // 1,2는 secondary
    }
}
