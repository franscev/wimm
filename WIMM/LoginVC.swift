
import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var recoverPassButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    }
    
    
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "doLoginSegue" {
            
            let tabBarContr = segue.destination as! TabBarContr
            goButton = sender as! UIButton
            
        } else if segue.identifier == "registerSegue" {
            let registerVC = segue.destination as! RegisterVC
            createAccountButton = sender as! UIButton
        } else if segue.identifier == "recoverSegue" {
            let recoverPassVC = segue.destination as! RecoverPassVC
            recoverPassButton = sender as! UIButton
        }
        
    }
    
}
