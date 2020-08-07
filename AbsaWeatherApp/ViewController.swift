//
//  ViewController.swift
//  AbsaWeatherApp
//
//  Created by Sibusiso on 2020/08/05.
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, ServiceResponseProtocol {
    var location:City?
    var currentWeather : WeatherForecast?
    let weatherService = DataRetievalService()
    let locationManager = CLLocationManager()
    var dailyTempKeys = [Date]()
    var dailyTemperatures  = DailyWeatherForecast()
    
    @IBOutlet weak var dailyTemperaturesTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherService.serviceCallResponseDelegate = self
        dailyTemperaturesTableView.delegate = self
        dailyTemperaturesTableView.dataSource = self
        dailyTemperaturesTableView.register(DailyTableViewCell.nib(), forCellReuseIdentifier: DailyTableViewCell.cellIdentifier)
        setupLocation()
    }
    
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            locationManager.requestWhenInUseAuthorization()
        default:
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty{
            locationManager.stopUpdatingLocation()
            guard let currentLocation = locations.first else{
                return
            }
            print(currentLocation.coordinate.longitude)
            print(currentLocation.coordinate.latitude)
            //weatherService.retriveWeatherData(dataType: .forecast, longitude: "29.250", latitude: "-26.950")
            weatherService.retriveWeatherData(dataType: .forecast, longitude: "\(String(currentLocation.coordinate.longitude))", latitude: "\(String(currentLocation.coordinate.latitude))")
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.dailyTemperaturesTableView.tableHeaderView = self.createCurrentWeatherHeader(location: self.location!, detailsViewData:self.dailyTemperatures.daysDictionary![self.dailyTempKeys[indexPath.row]]![0])
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (dailyTemperatures.daysDictionary?.keys != nil){
            return (dailyTemperatures.daysDictionary?.keys.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.cellIdentifier, for: indexPath) as! DailyTableViewCell
        cell.configureCell(weatherData: dailyTemperatures.daysDictionary![dailyTempKeys[indexPath.row]]![0])
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func weatherForecastResponse(location: City, weatherForecastList: DailyWeatherForecast) {
        dailyTempKeys = Array<Date>(weatherForecastList.daysDictionary!.keys)
        dailyTempKeys.sort(by: { $0.compare($1) == .orderedAscending })
        dailyTemperatures = weatherForecastList
        self.location = location
        DispatchQueue.main.async {
            self.dailyTemperaturesTableView.reloadData()
            self.dailyTemperaturesTableView.tableHeaderView = self.createCurrentWeatherHeader(location: self.location!, detailsViewData:self.dailyTemperatures.daysDictionary![self.dailyTempKeys[0]]![0])
        }
    }
    
    func createCurrentWeatherHeader(location: City ,detailsViewData: WeatherForecast) -> UIView{
        let headerView = Bundle.main.loadNibNamed("DetailsTableViewCell", owner: self, options: nil)?.first as! DetailsTableViewCell
        headerView.configureHeaderView(location:location, detailsViewData: detailsViewData)
        return headerView
    }
    
    
    func error_response(title: String, message: String) {
       let alert = UIAlertController(title: title, message: message, preferredStyle:.alert)
       alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action) in
           UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
           DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
               exit(EXIT_SUCCESS)
           })}))
       self.present(alert, animated: true , completion: nil)
    }
       
   func currentWeatherResponse(currentWeather: CurrentWeatherResponse) {
       //Not covered due to time constraints()
   }
}

