//
//  UserDefaultsManager.swift
//  LevelUpiOS
//
//  Created by 김민재 on 2/10/24.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T: Codable> {
    private let key: String
    private let defaultValue: T?

    init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T? {
        get {
            guard let loadedData = UserDefaults.standard.object(forKey: self.key) as? Data,
                  let decodedObject = try? JSONDecoder().decode(T.self, from: loadedData)
            else { return defaultValue }
            return decodedObject
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encodedData, forKey: self.key)
            }

        }
    }
}

struct UserDefaultsManager {
    @UserDefaultsWrapper(key: "cookie", defaultValue: nil)
    static var tokenKey: UserDefaultToken?
}


struct UserDefaultToken: Codable {
    var cookie: String?
}
