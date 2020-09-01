//
//  ConverterService.swift
//  AbsaWeatherApp
//
//  Created by Sibusiso on 2020/08/06.
//  Copyright © 2020 Sibusiso. All rights reserved.

import UIKit


public enum TemperatureUnit: Int{
    case celsius
    case fahrenheit
    case kelvin
}

class ConvertorService {
    
    public static func temperatureDescriptor(forTemperatureUnit temperatureUnit: TemperatureUnit, fromRawTemperature rawTemperature: Float) -> String {
        switch temperatureUnit {
        case .celsius:
            return "\(String(format:"%.02f", rawTemperature - 273.15))°C"
        case . fahrenheit:
            return "\(String(format:"%.02f", rawTemperature * (9/5) - 459.67))°F"
        case .kelvin:
            return "\(String(format:"%.02f", rawTemperature))°K"
        }
    }
    
    public static func dateConvertor(weatherDate: String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from:weatherDate)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from:components)!
    }
    
    
    public static func weatherObjectsFilter(weatherForecast:[WeatherForecast])->DailyWeatherForecast{
        var daysDictionary = [Date:[ WeatherForecast]]()
        for object in weatherForecast {
            if daysDictionary[dateConvertor(weatherDate: object.dt_txt!)] != nil{
                daysDictionary[dateConvertor(weatherDate:object.dt_txt!)]?.append(object)
            }else{
                var arr = [WeatherForecast]()
                arr.append(object)   
                daysDictionary[dateConvertor(weatherDate:object.dt_txt!)] = arr
            }
        }
        return DailyWeatherForecast(daysDictionary: daysDictionary)
    }
    
    
    public static func convertDateToDays(weatherDate: String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.weekdaySymbols[Calendar(identifier: .gregorian).component(.weekday, from: dateFormatter.date(from: weatherDate)!)-1]
    }
}






