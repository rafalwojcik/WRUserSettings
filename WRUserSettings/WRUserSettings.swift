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

import Foundation

public protocol SharedInstanceType: class {
    init(classType: AnyClass)
    func clearInstances()
}

private var userSettingsSingletons = [String: SharedInstanceType]()
extension SharedInstanceType {
    public static var shared: Self {
        let className = String(describing: self)
        guard let singleton = userSettingsSingletons[className] as? Self else {
            let singleton = Self.init(classType: self)
            userSettingsSingletons[className] = singleton
            return singleton
        }
        return singleton
    }

    public func clearInstances() {
        userSettingsSingletons = [:]
    }
}

@objcMembers
open class WRUserSettings: NSObject, SharedInstanceType {
    typealias Property = String

    private var migrationUserDefaultKey: String { return "MigrationKey-\(uniqueIdentifierKey)" }
    private let childClassName: String
    private var uniqueIdentifierKey: String { return "\(childClassName)-WRUserSettingsIdentifier" }
    private var userDefaults = UserDefaults.standard
    private var defaultValues: [String: Data] = [:]

    required public init(classType: AnyClass) {
        childClassName = String(describing: classType)
        super.init()
        if let suiteName = suiteName(), let newUserDefaults = UserDefaults(suiteName: suiteName) {
            migrateIfNeeded(from: userDefaults, to: newUserDefaults)
            userDefaults = newUserDefaults
        }
        let mirror = Mirror(reflecting: self)
        for attr in mirror.children {
            guard let property = attr.label else { continue }
            saveDefaultValue(property)
            fillProperty(property)
            observe(property: property)
        }
    }

    deinit {
        let mirror = Mirror(reflecting: self)
        for attr in mirror.children {
            guard let property = attr.label else { continue }
            self.removeObserver(self, forKeyPath: property)
        }
    }

    private func userDefaultsKey(forProperty property: Property) -> String {
        return "\(uniqueIdentifierKey).\(property)"
    }

    private func saveDefaultValue(_ property: Property) {
        guard let object = self.value(forKeyPath: property) else { return }
        let archivedObject = try? NSKeyedArchiver.data(object: object)
        defaultValues[property] = archivedObject
    }

    private func fillProperty(_ property: Property) {
        if let data = userDefaults.object(forKey: userDefaultsKey(forProperty: property)) as? Data {
            let value = NSKeyedUnarchiver.object(data: data)
            self.setValue(value, forKey: property)
        }
    }

    private func observe(property: Property) {
        self.addObserver(self, forKeyPath: property, options: [.new], context: nil)
    }

    open func suiteName() -> String? { return nil }

    private func migrateIfNeeded(from: UserDefaults, to: UserDefaults) {
        guard !from.bool(forKey: migrationUserDefaultKey) else { return }
        for (key, value) in from.dictionaryRepresentation() where key.hasPrefix(uniqueIdentifierKey) {
            to.set(value, forKey: key)
            from.removeObject(forKey: key)
        }
        guard to.synchronize() else { return }
        from.set(true, forKey: migrationUserDefaultKey)
        from.synchronize()
    }
}

// MARK: Public methods
extension WRUserSettings {
    public func reset() {
        for (property, defaultValue) in defaultValues {
            let value = NSKeyedUnarchiver.object(data: defaultValue)
            self.setValue(value, forKey: property)
        }
    }
}

// MARK: Description
extension WRUserSettings {
    override open var description: String {
        var settings = [String: Any]()
        for (key, value) in userDefaults.dictionaryRepresentation() where key.hasPrefix(uniqueIdentifierKey) {
            guard let data = value as? Data else { continue }
            let newKey = key.replacingOccurrences(of: "\(uniqueIdentifierKey).", with: "")
            let object = NSKeyedUnarchiver.object(data: data)
            settings[newKey] = object
        }
        return settings.description
    }
}

// MARK: KVO
extension WRUserSettings {
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else { return }
        let usKey = userDefaultsKey(forProperty: keyPath)
        guard let object = self.value(forKeyPath: keyPath) else {
            userDefaults.removeObject(forKey: usKey)
            return
        }
        let archivedObject = try? NSKeyedArchiver.data(object: object)
        userDefaults.set(archivedObject, forKey: usKey)
        userDefaults.synchronize()
    }
}

private extension NSKeyedUnarchiver {
    class func object(data: Data) -> Any? {
        if #available(iOS 11.0, macOS 10.12, *) {
            return (try? self.unarchiveTopLevelObjectWithData(data)) ?? nil
        } else {
            return self.unarchiveObject(with: data)
        }
    }
}

private extension NSKeyedArchiver {
    class func data(object: Any) throws -> Data {
        if #available(iOS 11.0, macOS 10.12, *) {
            return try self.archivedData(withRootObject: object, requiringSecureCoding: false)
        } else {
            return self.archivedData(withRootObject: object)
        }
    }
}

