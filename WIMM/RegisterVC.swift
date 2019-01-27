

import UIKit
import Alamofire


class RegisterVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var repeatPassField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var userField: UITextField!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var viewGray: UIView!
    
    @IBOutlet weak var goButton: UIButton!
    let blueDarkColor = "BlueDark"
    let uRL = "http:localhost:8888/touristme/public/api/user"
    
    var parameters: [String: String] = [
    "name" : "francisquito",
    "email" : "iosclient@cev.com",
    "password" : "francisquitoelmejor",
    "passwordConfirm": "francisquitoelmejor"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFieldDelegates()
        setUpBorderViews()
        //requestAlamofire()
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
    }
    
    @IBAction func sendInputFieldData(_ sender: Any) {
        
        let parametersInput: [String: String] = [
            "name" : userField.text!,
            "email" : mailField.text!,
            "password" : passField.text!,
            "passwordConfirm": repeatPassField.text!
        ]
        
        parameters = parametersInput
        requestAlamofire()
    }
    
    
    func requestAlamofire()
    {
        Alamofire.request(uRL, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseString {
            response in
            switch response.result {
            case .success:
                print("LA RESPUESTA ACEPTADA ES:", response)
                
                break
            case .failure(let error):
                print("LA RESPUESTA ERRÓNEA ES: ", error)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
    
    func setUpFieldDelegates(){
        repeatPassField.delegate = self
        passField.delegate = self
        mailField.delegate = self
        userField.delegate = self
        
    }
    
    func setUpBorderViews(){
        
        goButton.setTitle("GO", for: .normal)
        
        mainView.layer.borderWidth = 1.0
        mainView.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
        
        viewGray.layer.borderWidth = 1.0
        viewGray.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
        
        mailField.layer.borderWidth = 1.0
        mailField.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
        
        userField.layer.borderWidth = 1.0
        userField.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
        
        passField.layer.borderWidth = 1.0
        passField.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
        
        repeatPassField.layer.borderWidth = 1.0
        repeatPassField.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
        
        goButton.layer.borderWidth = 1.0
        goButton.layer.borderColor = UIColor(named: blueDarkColor)?.cgColor
    }

    @IBAction func goBackToLoginVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        userField.resignFirstResponder()
//    }

    
}


