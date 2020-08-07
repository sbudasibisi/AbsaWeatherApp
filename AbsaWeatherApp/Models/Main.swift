//
//  Main.swift
//  AbsaWeatherApp
//
//  Created by Sibusiso on 2020/08/06.
//  Copyright © 2020 Sibusiso. All rights reserved.

import UIKit

struct Main : Codable {
    let temp : Double?
    let pressure : Double?
    let humidity : Int?
    let temp_min : Double?
    let temp_max : Double?
    let sea_level : Double?
    let grnd_level : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case temp = "temp"
        case pressure = "pressure"
        case humidity = "humidity"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
        pressure = try values.decodeIfPresent(Double.self, forKey: .pressure)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        temp_min = try values.decodeIfPresent(Double.self, forKey: .temp_min)
        temp_max = try values.decodeIfPresent(Double.self, forKey: .temp_max)
        sea_level = try values.decodeIfPresent(Double.self, forKey: .sea_level)
        grnd_level = try values.decodeIfPresent(Double.self, forKey: .grnd_level)
    }
    
}
