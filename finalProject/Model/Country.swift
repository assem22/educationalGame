//
//  Country.swift
//  finalProject
//
//  Created by Assem Mukhamadi on 15.12.2020.
//

import Foundation
import RealmSwift


class Country: Object{
    @objc dynamic var country = ""
    @objc dynamic var capital = ""
    @objc dynamic var flag = ""
    @objc dynamic var region = ""
    @objc dynamic var subregion = ""
    @objc dynamic var population = 0
    @objc dynamic var area = 0.0
    @objc dynamic var nativeName = ""
}



//class Country{
//    var country: String
//    var capital: String
//    var flag: String
//    var region: String
//    var subregion: String
//    var population: Int
//    var area: Any
//    var nativeName: String
//    
//    init(country: String, capital: String, flag: String, region: String, subregion: String, population: Int, area: Any, nativeName: String) {
//        self.capital = capital
//        self.country = country
//        self.flag = flag
//        self.region = region
//        self.subregion = subregion
//        self.population = population
//        self.area = area
//        self.nativeName = nativeName
//    }
//}
