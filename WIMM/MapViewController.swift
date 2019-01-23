

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
    var nameOfAddress: String = ""
    var savedPlaces = [Place]()
    
    var coordX: Float = 0
    var coordY: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        //locationManager.startUpdatingLocation()
        initSearchTable()
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(action(gestureRecognizer:)))
        mapView.addGestureRecognizer(longGesture)
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
            locationManager.stopUpdatingLocation()
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
               
                
            }
            self.address = dir
            print("LA DIRECCIÓN ES: ", dir)
            self.nameOfAddress = dir
        }
    }
    
    // FORMATEAR PLACEMARK
    func stringFromPlacemark(placemark: CLPlacemark)->String{
        var line = ""
        
        if let p = placemark.thoroughfare{
            line += p + ", "
            print("La calle es : ", placemark.thoroughfare!)
        }
        if let p = placemark.subThoroughfare{
            line += p + ""
            print("El número es : ", placemark.subThoroughfare!)
        }
        if let p = placemark.locality{
            line += " (" + p + ")"
            print("La localidad es : ", placemark.locality!)
        }
            print("El nombre y número de la calle es: ", placemark.name!)
        
            nameOfAddress = placemark.name!
        
        return line
        
    }
    

    
    // PONER PIN A MANO
    @objc func action(gestureRecognizer: UIGestureRecognizer) {
        
        self.mapView.removeAnnotations(mapView.annotations)
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let newCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
    
        geocoderLocation(newLocation: CLLocation(latitude: newCoords.latitude, longitude: newCoords.longitude))
        
        let annotation = MKPointAnnotation()
        
  
        // COORDENADAS DEL PIN PUESTO CON EL DEDO O MOUSE
        annotation.coordinate = newCoords
        
        annotation.title = address
        //annotation.subtitle = address
        mapView.addAnnotation(annotation)
        
        //(print("LAS COORDENADAS DEL PIN A MANO SON: " , newCoords)
        
        coordX = Float(newCoords.longitude)
        coordY = Float(newCoords.latitude)
        
        
        print("LAS COORDENADAS DEL PIN A MANO SON: " , "Longitud: ",  coordX, "Latitud: " , coordY)
        
    }
    
        // INSTANCIANDO LA PANTALLA DE AÑADIR LUGAR, ADDPLACEVC
        @objc func instanceAddPlaceVC(){
           
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let addPlaceVC = storyboard.instantiateViewController(withIdentifier: "AddPlaceVC") as! AddPlace
            
            print("LA PRUEBA DEFINITORIA ES: ", selectedPin)

            addPlaceVC.fixedPin = selectedPin
            addPlaceVC.coordY = coordY
            addPlaceVC.coordX = coordX
            addPlaceVC.addressOfPlace = nameOfAddress
            
            self.present(addPlaceVC, animated: true)
        }
   
}

// DELEGADO DE LA UBICACIÓN DEL USUARIO
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

// DELEGADO PARA LA BARRA BÚSQUEDA DE UN LUGAR
extension MapViewController: HandleMapSearch {
    

    func dropPinZoomIn(_ placemark: MKPlacemark){
        
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        // cache the pin
        selectedPin = placemark
        
        
        let annotation = MKPointAnnotation()
        
        // COORDENADAS DEL PIN PUESTO MEDIANTE EL BUSCADOR
        annotation.coordinate = placemark.coordinate
        
        print("LAS COORDENADAS DEL PIN MEDIANTE BÚSQUEDA SON: " , "Longitud: ",  placemark.coordinate.longitude, "Latitud: " , placemark.coordinate.latitude)
        
        annotation.title = placemark.title
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
        
        nameOfAddress = annotation.title!
    }
}


// DELEGADO DEL MAPVIEW
extension MapViewController : MKMapViewDelegate{
    
    // FUNCIÓN QUE TE DEVUELVE UNA VISTA DEL ANNOTATIONVIEW (PIN)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {

        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
       
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        let button = UIButton()
        button.setImage(UIImage(named :"save")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.frame = CGRect(x: 25, y: 0, width: 50, height: 50)
        button.addTarget(self, action: #selector(MapViewController.instanceAddPlaceVC), for: .touchUpInside)
        annotationView?.rightCalloutAccessoryView = button
        
        let pinImage = UIImage(named: "pin")
        annotationView!.image = pinImage
        
        return annotationView
        }
    }


