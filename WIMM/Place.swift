
import UIKit

class Place: NSObject{

let name: String
let city: String
let descript: String
let startDate: String
let endDate: String
let xCoord: Float
let yCoord: Float


// SET CONSTRUCTOR
    init(name: String, city: String, descript: String, startDate: String, endDate:String, xCoord:Float, yCoord: Float) {
    self.name = name
    self.city = city
    self.descript = descript
    self.startDate = startDate
    self.endDate = endDate
    self.xCoord = xCoord
    self.yCoord = yCoord

    
    }
}


