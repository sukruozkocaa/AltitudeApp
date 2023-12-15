//
//  HomeViewController + Weather.swift
//  AltitudeApp
//
//  Created by Şükrü on 7.09.2023.
//

import Foundation
import CoreLocation
import UIKit

extension HomeViewController {
    
    /*
     *  Prepare WeatherView
     */
    
    func prepareWeatherView() {
        
        weatherView.backgroundColor = .init(hex: "#23282B")
        weatherView.layer.cornerRadius = 10
        weatherView.isHidden = true
        
        view.addSubview(weatherView)
        
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        weatherView.topAnchor.constraint(equalTo: gpsView.bottomAnchor, constant: 20).isActive = true
        weatherView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        weatherView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
    
    /*
     *  Prepare Weather Icon
     */
    
    func prepareWeatherIcon() {
        
        weatherIcon.contentMode = .scaleAspectFit
        
        weatherView.addSubview(weatherIcon)
        
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        weatherIcon.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: 5).isActive = true
        weatherIcon.leadingAnchor.constraint(equalTo: weatherView.leadingAnchor,constant: 5).isActive = true
        weatherIcon.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -5).isActive = true
        
    }
    
    /*
     *  Prepare Weather Degree Label
     */
    
    func prepareWeatherDegreeLabel() {
        
        weatherDegreeLabel.font = .systemFont(ofSize: 12, weight: .medium)
        weatherDegreeLabel.textColor = .white
        weatherDegreeLabel.textAlignment = .center
    
        weatherView.addSubview(weatherDegreeLabel)
        
        weatherDegreeLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherDegreeLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor).isActive = true
        weatherDegreeLabel.leadingAnchor.constraint(equalTo: weatherView.leadingAnchor).isActive = true
        weatherDegreeLabel.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor).isActive = true
        weatherDegreeLabel.bottomAnchor.constraint(equalTo: weatherView.bottomAnchor).isActive = true
        
    }
    
    /*
     *  Fetch Weather Data
     */
    
    func fetchWeather(location: CLLocation) {
                    
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=279e0edd36f297337177bdaa3a123e93") else {
                return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            do {
                guard let jsonResponse = try JSONSerialization.jsonObject(with: data!) as? [String: Any] else {
                    return
                }

                DispatchQueue.main.async {
                    
                    self.weatherView.isHidden = false
                    
                    if let main = jsonResponse["main"] as? [String: Any],
                        let temp = main["temp"] as? Double {
                        
                        self.weatherDegreeLabel.text = "\(String(Int(temp-272.15)))°"
                        
                    }

                    if let weatherArray = jsonResponse["weather"] as? [[String: Any]],
                       let firstWeather = weatherArray.first,
                       let icon = firstWeather["icon"] as? String {
                        
                        let image = self.getIcon(iconCode: icon).withRenderingMode(.alwaysTemplate)
                        self.weatherIcon.tintColor = .white
                
                        self.weatherIcon.image = image
                        
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getIcon(iconCode: String) -> UIImage {
        
        switch iconCode {
            
        case "01d":
            return UIImage(systemName: "sun.max")!
        case "02d":
            return UIImage(systemName: "cloud.sun.fill")!
        case "03d":
            return UIImage(systemName: "cloud.fill")!
        case "04d":
            return UIImage(systemName: "smoke.fill")!
        case "09d":
            return UIImage(systemName: "cloud.heavyrain")!
        case "10d":
            return UIImage(systemName: "cloud.drizzle")!
        case "11d":
            return UIImage(systemName: "cloud.bolt.rain")!
        case "13d":
            return UIImage(systemName: "snowflake")!
        case "50d":
            return UIImage(systemName: "cloud.fog")!
            
        // Night
            
        case "01n":
            return UIImage(systemName: "sun.max")!
        case "02n":
            return UIImage(systemName: "cloud.sun.fill")!
        case "03n":
            return UIImage(systemName: "cloud.fill")!
        case "04n":
            return UIImage(systemName: "smoke.fill")!
        case "09n":
            return UIImage(systemName: "cloud.heavyrain")!
        case "10n":
            return UIImage(systemName: "cloud.drizzle")!
        case "11n":
            return UIImage(systemName: "cloud.bolt.rain")!
        case "13n":
            return UIImage(systemName: "snowflake")!
        case "50n":
            return UIImage(systemName: "cloud.fog")!

        default: break
        }
        
        return UIImage()
    }
    
}
