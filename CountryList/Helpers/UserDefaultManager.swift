//
//  UserDefaultManager.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

struct UserDefaultManager {
    
    static let UserDefault = UserDefaults.standard

    static func setDataWith<T: Codable>(_ userDefaultValue: T?,
                                        key userDefaultKey: UserDefaultKey) {
        if let userDefaultValue = userDefaultValue {
            if let encodedData = try? JSONEncoder().encode(userDefaultValue) {
                UserDefault.set(encodedData, forKey: userDefaultKey.rawValue)
            }
        } else {
            removeUserDefaultWith(key: userDefaultKey)
        }
        UserDefault.synchronize()
    }

    static func getDataWith<T: Codable>(type userDefaultType: T.Type,
                                        key userDefaultKey: UserDefaultKey) -> T? {
        if let object = UserDefault.object(forKey: userDefaultKey.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let decodeValue = try? decoder.decode(userDefaultType.self, from: object) {
                return decodeValue
            }
        }
        return nil
    }

    static func removeUserDefaultWith(key userDefaultKey: UserDefaultKey){
        UserDefault.removeObject(forKey: userDefaultKey.rawValue)
    }
}
