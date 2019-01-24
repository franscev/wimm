
import UIKit

class RecoverPassVC: UIViewController, UITextFieldDelegate {


    @IBOutlet var mainView: UIView!
    @IBOutlet weak var viewGray: UIView!
    
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var confirmMailField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    
    let blueDarkColor = "BlueDark"
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        setUpBorderViews()
        setUpFieldDelegates()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
    }


    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setUpFieldDelegates(){
        confirmMailField.delegate = self
        mailField.delegate = self
        
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
        
        confirmMailField.layer.borderWidth = 1.0
        confirmMailField.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
        
        goButton.layer.borderWidth = 1.0
        goButton.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
    }
    
}
