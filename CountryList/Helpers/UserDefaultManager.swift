//
//  UserDefaultManager.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

struct UserDefaultManager {
    // MARK: - Variable
    static let userDefault = UserDefaults.standard

    // Set data in UserDefaults
    static func setDataWith<T: Codable>(_ userDefaultValue: T?,
                                        key userDefaultKey: UserDefaultKey) {
        if let userDefaultValue = userDefaultValue {
            if let encodedData = try? JSONEncoder().encode(userDefaultValue) {
                userDefault.set(encodedData, forKey: userDefaultKey.rawValue)
            }
        } else {
            removeUserDefaultWith(key: userDefaultKey)
        }
        userDefault.synchronize()
    }

    // Retrive data from UserDefaults
    static func getDataWith<T: Codable>(type userDefaultType: T.Type,
                                        key userDefaultKey: UserDefaultKey) -> T? {
        if let object = userDefault.object(forKey: userDefaultKey.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let decodeValue = try? decoder.decode(userDefaultType.self, from: object) {
                return decodeValue
            }
        }
        return nil
    }

    // Remove data from UserDefaults
    static func removeUserDefaultWith(key userDefaultKey: UserDefaultKey){
        userDefault.removeObject(forKey: userDefaultKey.rawValue)
    }
}
