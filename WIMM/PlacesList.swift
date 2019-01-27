
import UIKit

class PlacesList: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var placeCell = [PlaceCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()

        
    }
    
    // SET UP TABLE VIEW
    private func setUpTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
    }
    
    //TABLE VIEW
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "idPlace", for: indexPath) as? PlaceCell else{
            return PlaceCell()
        }
        
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let placeDetailVC = segue.destination as! PlaceDetailVC
        
        let cellPlace = sender as! PlaceCell
     
    }

}
