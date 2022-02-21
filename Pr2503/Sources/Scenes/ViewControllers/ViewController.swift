import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    fileprivate var password: String {
        get {
            return label.text ?? "Error"
        }
    
        set {
            self.textField.isSecureTextEntry = false
            self.indicator.hidesWhenStopped = true
            self.indicator.isHidden = true
            label.text = newValue
        }
    }
    
    var isBlack: Bool = false {
        didSet {
            if isBlack {
                DispatchQueue.main.async {
                    self.view.backgroundColor = .black
                }
            } else {
                DispatchQueue.main.async {
                    self.view.backgroundColor = .white
                }
            }
        }
    }
    
    private var bruteForce = BruteForce()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.isSecureTextEntry = true
        indicator.isHidden = true
        label.isHidden = true
    }
    
    @IBAction func onBut(_ sender: Any) {
        isBlack.toggle()
    }

    @IBAction func generateButton(_ sender: Any) {
        generatePassword()
    }
    
    fileprivate func generatePassword() {
        
        indicator.startAnimating()
        indicator.isHidden = false
        
        RandomStringGenerator.randomString { randomString in
            self.bruteForce.getBruteForce(passwordToUnlock: randomString)

        DispatchQueue.main.sync {
            self.label.isHidden = false
            self.textField.text = randomString
            self.password = self.textField.text ?? "Error"
            }
        }
    }
}




