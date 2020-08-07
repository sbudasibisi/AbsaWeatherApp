//
//  Rain.swift
//  AbsaWeatherApp
//
//  Created by Sibusiso on 2020/08/06.
//  Copyright © 2020 Sibusiso. All rights reserved.

import UIKit

struct Rain: Codable {
    let the3h : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case the3h = "3h"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        the3h = try values.decodeIfPresent(Double.self, forKey: .the3h)
    }
    
}
