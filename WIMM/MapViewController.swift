

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch: class {
    func dropPinZoomIn(_ placemark:MKPlacemark)
}



class MapViewController: UIViewController {
    
   
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    var resultSearchController: UISearchController!
    var selectedPin: MKPlacemark?
    
    var address: String = ""
    let geocoder = CLGeocoder()
    
    var savedPlaces = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        initSearchTable()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(action(gestureRecognizer:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func locateMe() {
        initLocation()
    }
    
    // SEARCH TABLE
    func initSearchTable(){
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchBarTable") as! LocationSearchBarTable
        
        
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
    }
    

    // LOCALIZAR MI UBICACIÓN
    func initLocation() {
        
        let permiso = CLLocationManager.authorizationStatus()
        
        if permiso == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if permiso == .denied {
            alertLocation(tit: "Error de localización", men: "Actualmente tiene denegada la localización del dispositivo.")
        } else if permiso == .restricted {
            alertLocation(tit: "Error de localización", men: "Actualmente tiene restringida la localización del dispositivo.")
        } else {
            
            guard let currentCoordinate = locationManager.location?.coordinate else { return }
            
            let region = MKCoordinateRegionMakeWithDistance(currentCoordinate, 500 , 500)
            mapView.setRegion(region, animated: true)
        }
    }
    
    // ALERTA ACEPTAR PERMISO LOCALIZACIÓN
    func alertLocation(tit: String, men: String) {
        
        let alerta = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alerta.addAction(action)
        self.present(alerta, animated: true, completion: nil)
    }
    
    
    // CONVERTIR COORDENADAS A DIRECCIÓN
    func geocoderLocation(newLocation: CLLocation){
        
        var dir = ""
        geocoder.reverseGeocodeLocation(newLocation){(placemarks,error) in
            if error == nil{
                dir = "The adress could not be determined"
            }
            if let placemark = placemarks?.last{
                dir = self.stringFromPlacemark(placemark: placemark)
                print(dir)
            }
            self.address = dir
        }
    }
    // FORMATEAR PLACEMARK
    func stringFromPlacemark(placemark: CLPlacemark)->String{
        var line = ""
        
        if let p = placemark.thoroughfare{
            line += p + ","
        }
        if let p = placemark.subThoroughfare{
            line += p + ""
        }
        if let p = placemark.locality{
            line += " (" + p + ")"
        }
        return line
    }
    

    
    
    // PONER PIN A MANO
    @objc func action(gestureRecognizer: UIGestureRecognizer) {
        
        self.mapView.removeAnnotations(mapView.annotations)
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let newCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        geocoderLocation(newLocation: CLLocation(latitude: newCoords.latitude, longitude: newCoords.longitude))
        
        let annotation = MKPointAnnotation()
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        
        
        
        
        
        // COORDENADAS DEL PIN PUESTO CON EL DEDO O MOUSE
        annotation.coordinate = newCoords
        
        annotation.title = address
        //        annotation.subtitle = address
        mapView.addAnnotation(annotation)
        
        
        print("LAS COORDENADAS DEL PIN A MANO SON: " , newCoords)
    }
}



extension MapViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
}

extension MapViewController: HandleMapSearch {
    
    func dropPinZoomIn(_ placemark: MKPlacemark){
        mapView.removeAnnotations(mapView.annotations)
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        
        
        
        let annotation = MKPointAnnotation()
        
        // COORDENADAS DEL PIN PUESTO MEDIANTE EL BUSCADOR
        annotation.coordinate = placemark.coordinate
        print("LAS COORDENADAS DEL PIN MEDIANTE BÚSQUEDA SON: " , placemark.coordinate)
        
        annotation.title = placemark.title
        //        annotation.subtitle = placemark.name
        
        //        if let city = placemark.locality,
        //            let state = placemark.administrativeArea {
        //            annotation.subtitle = "\(city) \(state)"
        //        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
}

extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        guard !(annotation is MKUserLocation) else { return nil }
        
        let reuseId = "pin"
        guard let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView else { return nil }
        

        pinView.canShowCallout = true
        pinView.pinTintColor = UIColor.blue
        
        //        let smallSquare = CGSize(width: 30, height: 30)
        //        var button: UIButton?
        ////        button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        ////        button?.setBackgroundImage(UIImage(named: "car"), for: UIControlState())
        //////        button?.addTarget(self, action: #selector(PlaceDetailVC.getDirections), for: .touchUpInside)
        ////        pinView.leftCalloutAccessoryView = button
        
        
        
        return pinView
    }
}
