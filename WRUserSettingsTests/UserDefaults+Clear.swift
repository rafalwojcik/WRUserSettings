import Foundation

extension UserDefaults {
    func clear() {
        for (key, _) in dictionaryRepresentation() {
            removeObject(forKey: key)
        }
        synchronize()
    }
}
