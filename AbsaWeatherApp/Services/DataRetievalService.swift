//
//  DataRetievalService.swift
//  AbsaWeatherApp
//
//  Created by Sibusiso on 2020/08/06.
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit


public enum weatherDataType:Int{
    case forecast
    case currentWeather
}

class DataRetievalService: NSObject {
    
    var serviceCallResponseDelegate: ServiceResponseProtocol?
    
    override init() {
        let status = Reachability().connectionStatus()
        switch status {
            case .unknown, .offline:
                serviceCallResponseDelegate?.error_response(title: "Error encountered", message: "Unable to reach network.")
                break
        case .online(_):
            break
        }
    }
    
    func retriveWeatherData(dataType: weatherDataType, longitude: String, latitude: String){
        var connectionURL: String?
        switch dataType {
        case .forecast:
            connectionURL  = "http://api.openweathermap.org/data/2.5/forecast?lat="+latitude+"&lon="+longitude+"&APPID=f45d586989f82d913c7b056bbfcb3aab"
        case .currentWeather:
            connectionURL = "http://api.openweathermap.org/data/2.5/weather?lat="+latitude+"&lon="+longitude+"&APPID=f45d586989f82d913c7b056bbfcb3aab"
        }
        if let url = NSURL(string: connectionURL!){
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration).dataTask(with: url as URL, completionHandler: {(data, response, error) in
                if let error = error{
                    self.serviceCallResponseDelegate?.error_response(title: "Error encountered", message: error.localizedDescription)
                }else{
                    print(String(data: data!, encoding: String.Encoding.utf8)!)
                    if let weatherForecastResponse = try? JSONDecoder().decode(WeatherFocustResponse.self, from: data!){
                        self.serviceCallResponseDelegate?.weatherForecastResponse(location:weatherForecastResponse.city!, weatherForecastList: ConvertorService.weatherObjectsFilter(weatherForecast: weatherForecastResponse.list!))
                    }else if let currentWeatherResponse = try? JSONDecoder().decode(CurrentWeatherResponse.self, from: data!){
                        self.serviceCallResponseDelegate?.currentWeatherResponse(currentWeather: currentWeatherResponse)
                    }else{
                        self.serviceCallResponseDelegate?.error_response(title: "Error encountered", message: "Unable to properly handle response data")
                    }
                }
                })
            session.resume()
        }
    }

}
