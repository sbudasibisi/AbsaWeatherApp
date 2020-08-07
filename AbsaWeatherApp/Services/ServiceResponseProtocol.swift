//
//  ServiceResponseProtocol.swift
//  AbsaWeatherApp
//
//  Created by Sibusiso on 2020/08/06.
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit

protocol ServiceResponseProtocol {
    
    func error_response(title: String, message: String)
    func currentWeatherResponse(currentWeather: CurrentWeatherResponse)
    func weatherForecastResponse(location:City ,weatherForecastList: DailyWeatherForecast)

}
