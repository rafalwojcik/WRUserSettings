import UIKit
import WRUserSettings

class ViewController: UIViewController {
    @IBOutlet weak var tutorialSwitch: UISwitch!
    @IBOutlet weak var temperatureTextField: UITextField!
    @IBOutlet weak var notificationSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
    }

    func populateData() {
        tutorialSwitch.isOn = MyUserSettings.shared.shouldShowTutorial
        temperatureTextField.text = MyUserSettings.shared.temperatureUnit
        notificationSwitch.isOn = MyUserSettings.shared.notificationOn
    }

    @IBAction func temperatureChanged(_ sender: UITextField) {
        MyUserSettings.shared.temperatureUnit = sender.text ?? ""
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        switch sender {
            case tutorialSwitch: MyUserSettings.shared.shouldShowTutorial = sender.isOn
            case notificationSwitch: MyUserSettings.shared.notificationOn = sender.isOn
            default: break
        }
    }

    @IBAction func resetTapped(_ sender: Any) {
        MyUserSettings.shared.reset()
        populateData()
    }
}
