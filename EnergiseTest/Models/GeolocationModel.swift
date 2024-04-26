//
//  GeolocationModel.swift
//  EnergiseTest
//
//  Created by Evgeniy Zelinskiy on 25.04.2024.
//

import Foundation

struct GeolocationModel: Decodable {
    let query: String
    let country: String
    let countryCode: String
    let regionName: String
    let city: String
    let zip: String
    let lat: Double
    let lon: Double
    let timezone: String
    let org: String
    
    init(from userDefaults: UserDefaults) {
        self.query = userDefaults.string(forKey: "query") ?? ""
        self.country = userDefaults.string(forKey: "country") ?? ""
        self.countryCode = userDefaults.string(forKey: "countryCode") ?? ""
        self.regionName = userDefaults.string(forKey: "regionName") ?? ""
        self.city = userDefaults.string(forKey: "city") ?? ""
        self.zip = userDefaults.string(forKey: "zip") ?? ""
        self.lat = userDefaults.double(forKey: "lat") 
        self.lon = userDefaults.double(forKey: "lon")
        self.timezone = userDefaults.string(forKey: "timezone") ?? ""
        self.org = userDefaults.string(forKey: "org") ?? ""
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(self.query, forKey: "query")
        defaults.set(self.country, forKey: "country")
        defaults.set(self.countryCode, forKey: "countryCode")
        defaults.set(self.regionName, forKey: "regionName")
        defaults.set(self.city, forKey: "city")
        defaults.set(self.zip, forKey: "zip")
        defaults.set(self.lat, forKey: "lat")
        defaults.set(self.lon, forKey: "lon")
        defaults.set(self.timezone, forKey: "timezone")
        defaults.set(self.org, forKey: "org")
        defaults.synchronize()
    }
}
