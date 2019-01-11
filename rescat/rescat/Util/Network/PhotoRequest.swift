
import Foundation
import Alamofire
import UIKit
import SwiftyJSON
class PhotoRequest {
    static func uploadPhotos( _ data : Data) -> String{
        
        let header = UserInfo.getHeader()
        let url = "http://13.209.145.139:8080/api/photo"
       
        var returnStr = ""
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(data, withName: "data", fileName: "image.png", mimeType: "image/png")
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: header) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    
                    guard let photo = response.result.value else { return }
                    print(photo)
                
                    let photoUrl = JSON(photo)["photoUrl"]
                    guard let str = photoUrl.string else { return }
                    returnStr = str
                    
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
            }
        }
        return returnStr
        
    }
    static func deletePhoto( _ str : String ) {
        
//        let str = "https://rescat.s3.ap-northeast-2.amazonaws.com/static/1546999813881_image.png"
        let header = UserInfo.getHeader()
        let url = "http://13.209.145.139:8080/api/photo?photoUrl=\(str)"
        Alamofire.request(url, headers: header).responseData { (res) in
            switch res.result {
            case .success:
                print("success")
            case .failure(let error):
                print("delete photo failure")
            }
        }
    }
        
    
}

