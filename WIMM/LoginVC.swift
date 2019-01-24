
import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var recoverPassButton: UIButton!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var viewGray: UIView!

    let blueDarkColor = "BlueDark"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mailField.delegate = self
        passField.delegate = self
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        setUpBorderViews()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if (string == " ") {
    return false
    }
    return true
    }
    
    func setUpBorderViews(){
        
        goButton.setTitle("GO", for: .normal)
        
        mainView.layer.borderWidth = 1.0
        mainView.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
        
        viewGray.layer.borderWidth = 1.0
        viewGray.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
        
        mailField.layer.borderWidth = 1.0
        mailField.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
        
        passField.layer.borderWidth = 1.0
        passField.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
        
        goButton.layer.borderWidth = 1.0
        goButton.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
    }
    
    
//    func doneButtonAction(){
//        self.view.endEditing(true)
//    }
    
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

//extension LoginVC : UITextFieldDelegate{
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        textField.resignFirstResponder()
//        //or
////        self.view.endEditing(true)
//        return true
//    }
//
//}
//
