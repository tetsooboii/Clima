import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) -> Void
    
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    let APIkey: String
    let weatherURL:String
    
    var delegate: WeatherManagerDelegate?
    
    init() {
        APIkey = "4ad6846477cdae902e9baddb33c5ceef"
        weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=\(APIkey)"
    }
    
    
    func fetchWeather(city: String){
        let urlString = "\(weatherURL)&q=\(city)"
                performRequest(urlString: urlString)
//        requestor(urlString: urlString)
        
    }
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
                performRequest(urlString: urlString)
//        requestor(urlString: urlString)
        
    }
        func performRequest(urlString: String){
            if let url = URL(string: urlString){
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, response, error in
                    if error != nil{
                        self.delegate?.didFailWithError(error!)
                        return
                    }
                    if let safeData = data{
                        if let weather = parseJSON(weatherData: safeData){
                            self.delegate?.didUpdateWeather(self, weather: weather)
                        }
                    }
                }
                task.resume()
            }
        }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weatherId = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: weatherId, cityName: name, temperature: temp)
            
            return weather
        } catch{
            self.delegate?.didFailWithError(error)
            return nil
        }
        
    }
    
    
    
    
    //Below my implementation of working with API
//    func requestor(urlString: String){
//
//        let url = URL(string: urlString)
//        let urlSession = URLSession(configuration: .default).dataTask(with: url!) { data, response, err in
//            if err != nil {
//                return
//            }
//            if let safeData = data {
//                let dataString = String(data: safeData, encoding: .utf8)
//                print(dataString)
//            }
//        }
//        urlSession.resume()
//    }
    
}


