import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
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
    
   private let queue = OperationQueue()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modeNotStarted()
    }
    
    @IBAction func onBut(_ sender: Any) {
        isBlack.toggle()
    }

    @IBAction func generateButton(_ sender: Any) {
        modeStart()
        
        guard let splitedPassword = textField.text?.split() else { return }
        var arrayBruteForcePassword:[BruteForce] = []
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            splitedPassword.forEach { element in
                arrayBruteForcePassword.append(BruteForce(password: element))
            }
            
            arrayBruteForcePassword.forEach { operation in
                self.queue.addOperation(operation)
            }
            
            self.queue.addBarrierBlock { [unowned self] in
                DispatchQueue.main.async {
                    self.label.text = "\(self.textField.text ?? "Error")"
                    self.modeCompleted()
                }
            }
        }
    }
    
    fileprivate func modeNotStarted() {
        textField.placeholder = "Пароль"
        textField.isSecureTextEntry = true
        generateButton.setTitle("Начать", for: .normal)
        indicator.stopAnimating()
        indicator.isHidden = true
    }

    fileprivate func modeStart() {
        label.text = "Подбирается пароль..."
        textField.text = String.random()
        generateButton.isEnabled = false
        indicator.startAnimating()
        indicator.isHidden = false
    }

   fileprivate func modeCompleted() {
        textField.isSecureTextEntry = false
        generateButton.isEnabled = true
        generateButton.setTitle("Начать", for: .normal)
        indicator.stopAnimating()
        indicator.isHidden = true
    }
}





