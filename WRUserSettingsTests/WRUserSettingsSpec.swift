import Foundation
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
