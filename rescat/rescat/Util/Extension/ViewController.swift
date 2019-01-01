
import Foundation
import UIKit
extension UIViewController {
    func gsno(_ value : String?) -> String{
        if let _value = value{
            return _value
        }else{
            return ""
        }
    }
    func gino(_ value : Int?) -> Int{
        if let _value = value{
            return _value
        }else{
            return -1
        }
    }
    func gfno(_ value : Float?) -> Float{
        if let _value = value{
            return _value
        }else{
            return -1.0
        }
    }
    func gdno(_ value : Double?) -> Double{
        if let _value = value{
            return _value
        }else{
            return -1.0
        }
    }
    func gbno(_ value : Bool?) -> Bool {
        if let _value = value {
            return _value
        }else {
            return false
        }
    }
}
