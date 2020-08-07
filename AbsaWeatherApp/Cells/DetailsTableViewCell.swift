//
//  DetailsTableViewCell.swift
//  AbsaWeatherApp
//
//  Created by Sibusiso on 2020/08/05.
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLocation: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configureHeaderView(location: City, detailsViewData: WeatherForecast){
        descriptionLocation.text = "Desciption: "+detailsViewData.weather![0].description!
        humidityLabel.text = "Humidity: \(String(describing: detailsViewData.main!.humidity!))%"
        windSpeedLabel.text = "Speed: \(String(describing: detailsViewData.wind!.speed!))mph"
        dateLabel.text = detailsViewData.dt_txt!
        iconImageView.image = UIImage(named: (detailsViewData.weather![0].icon!))
        temperatureLabel.text = "\(String(ConvertorService.temperatureDescriptor(forTemperatureUnit: .celsius, fromRawTemperature: Float(detailsViewData.main!.temp!))))"
        locationLabel.text = location.name!
    }
}
