//
// Copyright (c) 2019 Chilli Coder - Rafał Wójcik
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
