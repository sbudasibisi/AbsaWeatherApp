//
//  WeatherFocustResponse.swift
//  AbsaWeatherApp
//
//  Created by Sibusiso on 2020/08/06.
//  Copyright © 2020 Sibusiso. All rights reserved.

import UIKit

struct WeatherFocustResponse: Codable {
    
    
    let cod : String?
    let message : Double?
    let cnt : Int?
    let list : [WeatherForecast]?
    let city : City?
    
    enum CodingKeys: String, CodingKey {
        
        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cod = try values.decodeIfPresent(String.self, forKey: .cod)
        message = try values.decodeIfPresent(Double.self, forKey: .message)
        cnt = try values.decodeIfPresent(Int.self, forKey: .cnt)
        list = try values.decodeIfPresent([WeatherForecast].self, forKey: .list)
        city = try values.decodeIfPresent(City.self, forKey: .city)
    }
    
}
//
//    let list: [WeatherForecastList]
//    let cod: String
//    let cnt: Int
//    let message: Double
//    let city: City
//}
