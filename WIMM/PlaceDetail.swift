
import UIKit
import CoreLocation
import MapKit

class PlaceDetail: UIViewController {

//    let locationManager = CLLocationManager()
//    @IBOutlet weak var mapView: MKMapView!
//    let geocoder = CLGeocoder()
//    var address = ""
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        mapView.showsUserLocation = true
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        locationManager.startUpdatingLocation()
//
//        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.action(gestureRecognizer:)))
//        mapView.addGestureRecognizer(tapGesture)
//    }
//
//
//    @IBAction func locationUser() {
//        initLocation()
//    }
//
//    func initLocation(){
//        let permission = CLLocationManager.authorizationStatus()
//
//        if permission == .notDetermined{
//            locationManager.requestWhenInUseAuthorization()
//        }else if permission == .denied{
//            alertLocation(tit: "Error in the location", men: "Currently the location of the device is denied.")
//        }else if permission == .restricted{
//            alertLocation(tit: "Error in the location", men: "Currently the location of the device is restricted.")
//        }else{
//            guard let currentCoordinate = locationManager.location?.coordinate else{return}
//
//            let region = MKCoordinateRegionMakeWithDistance(currentCoordinate,500,500)
//
//            mapView.setRegion(region, animated: true)
//        }
//    }
//
//    func alertLocation(tit: String, men: String){
//        let alert = UIAlertController(title: tit, message: men, preferredStyle: .alert)
//        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
//        alert.addAction(action)
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    @objc func action(gestureRecognizer: UIGestureRecognizer){
//
//        self.mapView.removeAnnotations(mapView.annotations)
//        let touchPoint = gestureRecognizer.location(in: mapView)
//        let newCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
//
//        geocoderLocation(newLocation: CLLocation(latitude: newCoords.latitude, longitude: newCoords.longitude))
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = newCoords
//        annotation.title = "Dirección"
//        annotation.subtitle = address
//        mapView.addAnnotation(annotation)
//
//
//        //print(newCoords)
//        //print(annotation)
//    }
//
//    func geocoderLocation(newLocation: CLLocation){
//
//
////        let allAnnotations = self.mapView.annotations
////        self.mapView.removeAnnotations(allAnnotations)
//
//        var dir = ""
//        geocoder.reverseGeocodeLocation(newLocation){(placemarks,error) in
//            if error == nil{
//                dir = "The adress could not be determined"
//            }
//            if let placemark = placemarks?.last{
//                dir = self.stringFromPlacemark(placemark: placemark)
//               print(dir)
//            }
//            self.address = dir
//        }
//    }
//
//    func stringFromPlacemark(placemark: CLPlacemark)->String{
//        var line = ""
//
//        if let p = placemark.thoroughfare{
//            line += p + ","
//        }
//        if let p = placemark.subThoroughfare{
//            line += p + ""
//        }
//        if let p = placemark.locality{
//            line += " (" + p + ")"
//        }
//        return line
//    }
//
//}
//
//extension ViewController : MKMapViewDelegate {
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation {
//            return nil
//        }
//
//        let annotationID = "AnnotationID"
//
//        var annotationView : MKAnnotationView?
//
//        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationID) {
//            annotationView = dequeuedAnnotationView
//            annotationView?.annotation = annotation
//        } else {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationID)
//        }
//
//        if let annotationView = annotationView {
//            annotationView.canShowCallout = true
//            annotationView.image = UIImage(named: "img_pin")
//        }
//        return annotationView
//    }
//}
//
//extension PlaceDetail : CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        //print(locations[0])
//    }
//
//
}

