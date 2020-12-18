//
//  User.swift
//  finalProject
//
//  Created by Assem Mukhamadi on 15.12.2020.
//

import Foundation
import RealmSwift


class User: Object {
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var pasword = ""
    @objc dynamic var profileImage: NSData?
    let flags = List<Country>()
    let capitals = List<Country>()
}
