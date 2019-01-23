

import UIKit

class RegisterVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
    }


    @IBAction func goLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
