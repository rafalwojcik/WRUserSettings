import Foundation
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

import Quick
import Nimble
@testable import WRUserSettings

class WRUserSettingsSpec: QuickSpec {
    override func spec() {
        describe("MyUserSettings", closure: {
            beforeEach {
                UserDefaults.standard.clear()
                UserDefaults(suiteName: "me.rwojcik.wrusersettings")?.clear()
                MyUserSettings.shared.clearInstances()
                MyUserSettings.shared.reset()
            }

            it("should set value in user defaults") {
                MyUserSettings.shared.shouldShowTutorial = false
                expect(MyUserSettings.shared.shouldShowTutorial).to(beFalse())
                MyUserSettings.shared.notificationOn = true
                expect(MyUserSettings.shared.notificationOn).to(beTrue())
                MyUserSettings.shared.temperatureUnit = "F"
                expect(MyUserSettings.shared.temperatureUnit).to(equal("F"))
            }

            it("should allow to clear optional value") {
                let date = Date()
                MyUserSettings.shared.lastSyncDate = date
                expect(MyUserSettings.shared.lastSyncDate).to(equal(date))
                MyUserSettings.shared.lastSyncDate = nil
                expect(MyUserSettings.shared.lastSyncDate).to(beNil())
            }

            it("should remain values over app restarts") {
                MyUserSettings.shared.shouldShowTutorial = false
                MyUserSettings.shared.notificationOn = true
                MyUserSettings.shared.temperatureUnit = "F"
                MyUserSettings.shared.clearInstances()
                expect(MyUserSettings.shared.shouldShowTutorial).to(beFalse())
                expect(MyUserSettings.shared.notificationOn).to(beTrue())
                expect(MyUserSettings.shared.temperatureUnit).to(equal("F"))
            }

            it("should allow to reset values to defaults") {
                MyUserSettings.shared.shouldShowTutorial = false
                MyUserSettings.shared.notificationOn = true
                MyUserSettings.shared.temperatureUnit = "F"
                MyUserSettings.shared.reset()
                expect(MyUserSettings.shared.shouldShowTutorial).to(beTrue())
                expect(MyUserSettings.shared.notificationOn).to(beFalse())
                expect(MyUserSettings.shared.temperatureUnit).to(equal("C"))
            }
        })
    }
}
