import Foundation
import WRUserSettings

class MyUserSettings: WRUserSettings {
    dynamic var shouldShowTutorial: Bool = true
    dynamic var temperatureUnit: String = "C"
    dynamic var notificationOn: Bool = false
}
