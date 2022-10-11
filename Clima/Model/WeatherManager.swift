import Foundation

struct WeatherManager {
    let APIkey: String
    let weatherURL:String
    
    init() {
        APIkey = "4ad6846477cdae902e9baddb33c5ceef"
        weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=\(APIkey)"
    }
    
    
    func featchWeather(city: String){
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(urlString: urlString)

    }
    func performRequest(urlString: String){
        // 1. create url
        if let url = URL(string: urlString){
            // 2. create a url session
            let session = URLSession(configuration: .default)
            // 3. give the session a task
            
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            // 4. Start the task
            task.resume()
        }
        
    }
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
        if error != nil{
            print(error!)
            return
        }
        
        if let safeData = data{
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
            
        }
    }
    
    
}


