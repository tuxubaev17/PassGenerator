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
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            label.text = newValue
        }
    }
    
    var isBlack: Bool = false {
        didSet {
            if isBlack {
                self.view.backgroundColor = .black
            } else {
                self.view.backgroundColor = .white
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.isSecureTextEntry = true
        indicator.isHidden = true
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
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            let randomPassword = self.randomString(length: 3)
            self.bruteForce(passwordToUnlock: randomPassword)
            DispatchQueue.main.sync {
                self.textField.text = randomPassword
                self.password = self.textField.text ?? "Error"

            }
        }
        
    }
    
    // Generating Random String
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }

        var password: String = ""

        // Will strangely ends at 0000 instead of ~~~
        while password != passwordToUnlock { // Increase MAXIMUM_PASSWORD_SIZE value for more
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
//             Your stuff here
            print(password)
            // Your stuff here
        }
        
        print(password)
    }
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
                               : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string

    if str.count <= 0 {
        str.append(characterAt(index: 0, array))
    }
    else {
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }

    return str
}

