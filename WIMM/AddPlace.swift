
import UIKit
import MapKit

class AddPlace: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    
    var datePickerIndexPath: IndexPath?
    var inputTexts: [String] = ["Start date", "End date"]
    var inputDates: [Date] = []
    
    var coordenadasPin = CLLocationCoordinate2D()
    var coordX: Double = 0
    var coordY: Double = 0
    var addressOfPlace: String = ""
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        
        mapView.delegate = self
        
        
        addressLabel.text = addressOfPlace
        print("LA PRUEBA DE PASAR DATOS COORD Y ES :" , coordY)
        
        addInitailValues()
        setupTableView()
        print("XxXXXXXXXX", coordenadasPin)
        setUpPin(coordenadasPin)
        
    }
    
    func setUpPin(_ coordinate: CLLocationCoordinate2D){
        
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = addressOfPlace
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 450 , 450)
        mapView.setRegion(region, animated: true)
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func setupTableView() {
//        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height), style: .grouped)
//        view.addSubview(tableView)
        
        tableView.register(UINib(nibName: DateTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: DateTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: DatePickerTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: DatePickerTableViewCell.reuseIdentifier())
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func addInitailValues() {
        inputDates = Array(repeating: Date(), count: inputTexts.count)
    }
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return indexPath
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }
    
}

extension AddPlace: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if datePickerIndexPath != nil {
            return inputTexts.count + 1
        } else {
            return inputTexts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if datePickerIndexPath == indexPath {
            let datePickerCell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.reuseIdentifier()) as! DatePickerTableViewCell
            datePickerCell.updateCell(date: inputDates[indexPath.row - 1], indexPath: indexPath)
            datePickerCell.delegate = self
            return datePickerCell
        } else {
            let dateCell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.reuseIdentifier()) as! DateTableViewCell
            dateCell.updateText(text: inputTexts[indexPath.row], date: inputDates[indexPath.row])
            return dateCell
        }
    }
    
}

extension AddPlace: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row - 1 == indexPath.row {
            tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            self.datePickerIndexPath = nil
        } else {
            if let datePickerIndexPath = datePickerIndexPath {
                tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            }
            datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
            tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerIndexPath == indexPath {
            return DatePickerTableViewCell.cellHeight()
        } else {
            return DateTableViewCell.cellHeight()
        }
    }
    
}

extension AddPlace: DatePickerDelegate {
    
    func didChangeDate(date: Date, indexPath: IndexPath) {
        inputDates[indexPath.row] = date
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}

// DELEGADO DEL MAPVIEW
extension AddPlace : MKMapViewDelegate{
    
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
        
        let pinImage = UIImage(named: "PinNaranja")
        let resizedSize = CGSize(width: 45, height: 45)
        
        UIGraphicsBeginImageContext(resizedSize)
        pinImage!.draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        annotationView?.image = resizedImage
        annotationView!.image = resizedImage
        
        return annotationView
    }
}

