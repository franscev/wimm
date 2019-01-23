
import UIKit
import MapKit

class Pin: NSObject {
    
    var fixedPin = MKPlacemark()
    
    init(fixedPin: MKPlacemark) {
        self.fixedPin = fixedPin
    }
}
