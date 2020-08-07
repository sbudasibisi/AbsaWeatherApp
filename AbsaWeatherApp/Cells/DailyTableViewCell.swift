//
//  DailyTableViewCell.swift
//  AbsaWeatherApp
//
//  Created by Sibusiso on 2020/08/05.
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dailyLowLabel: UILabel!
    @IBOutlet weak var dailyHighLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    
    static let cellIdentifier = "DailyTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "DailyTableViewCell", bundle: nil)
    }
    
    
    func configureCell(weatherData: WeatherForecast){
        
        self.dayLabel.text = ConvertorService.convertDateToDays(weatherDate: weatherData.dt_txt!)
        self.dailyLowLabel.text = ConvertorService.temperatureDescriptor(forTemperatureUnit: .celsius, fromRawTemperature: Float(weatherData.main!.temp_min!))
        self.dailyHighLabel.text = ConvertorService.temperatureDescriptor(forTemperatureUnit: .celsius, fromRawTemperature: Float(weatherData.main!.temp_max!))
        self.weatherImageView.image = UIImage(named: (weatherData.weather![0].icon!))
    }

}
