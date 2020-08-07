//
//  CurrentWeather.swift
//  AbsaWeatherApp
//
//  Created by Sibusiso on 2020/08/06.
//  Copyright © 2020 Sibusiso. All rights reserved.

import UIKit

struct CurrentWeather: Codable {
    let id: Int
    let main, description, icon: String
}
