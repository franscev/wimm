
import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var recoverPassButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
//        //init toolbar
//        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
//        //create left side empty space so that done button set on right side
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: Selector("doneButtonAction"))
//        toolbar.setItems([flexSpace, doneBtn], animated: false)
//        toolbar.sizeToFit()
//        //setting toolbar as inputAccessoryView
//        self.mailField.inputAccessoryView = toolbar
//        self.passField.inputAccessoryView = toolbar
//
//
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
