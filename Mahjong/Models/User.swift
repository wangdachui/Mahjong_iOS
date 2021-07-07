//
//  User.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import UIKit
import MultipeerKit

public struct User: Codable {
//    var avatar: UIImage? = UIImage(named: "photo")
    var name: String = ""
    var uuid: String = ""
    var isLocalUser: Bool = false
    
    static func localUser() -> User {
        var user = User()
        user.name = UIDevice.current.name
        user.uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        user.isLocalUser = true
        return user
    }
}

public struct Participant: Codable {
    var user: User
    var isReady: Bool = false
    var isHomeowner: Bool = false
    var isBoolmarker: Bool = false
    init(_ user: User) {
        self.user = user
    }
}
