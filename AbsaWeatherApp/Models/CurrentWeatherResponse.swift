//
//  WeatherResponse.swift
//  AbsaWeatherApp
//
//  Created by Sibusiso on 2020/08/06.
//  Copyright © 2020 Sibusiso. All rights reserved.

import UIKit

struct CurrentWeatherResponse: Codable {
    let coord : Coord?
    let weather : [Weather]?
    let base : String?
    let main : Main?
    let wind : Wind?
    let rain : Rain?
    let clouds : Clouds?
    let dt : Int?
    let sys : Sys?
    let id : Int?
    let name : String?
    let cod : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case coord = "coord"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case wind = "wind"
        case rain = "rain"
        case clouds = "clouds"
        case dt = "dt"
        case sys = "sys"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coord = try values.decodeIfPresent(Coord.self, forKey: .coord)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        base = try values.decodeIfPresent(String.self, forKey: .base)
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
        rain = try values.decodeIfPresent(Rain.self, forKey: .rain)
        clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
        sys = try values.decodeIfPresent(Sys.self, forKey: .sys)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        cod = try values.decodeIfPresent(Int.self, forKey: .cod)
    }
    
}
