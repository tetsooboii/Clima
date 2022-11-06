//
//  WeatherData.swift
//  Clima
//
//  Created by Temirlan Bekkozha on 12.10.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherData : Codable{
    let name : String
    let cod : Int
    let id : Int
    let timezone : Int
    let main : Main
    let weather : [Weather]
}
struct Weather : Codable {
    let id : Int
    let main : String
    let description : String
}

struct Main : Codable {
    let temp : Double
}
