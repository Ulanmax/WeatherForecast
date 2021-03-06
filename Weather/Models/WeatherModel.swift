//
//  WeatherModel.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/25.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation

public class WeatherModel: Codable {
    
    public let id: Int
    public let name: String
    public let weather: [WeatherDescModel]
    public let main: TempModel
    
    public init(
        id: Int,
        name: String,
        weather: [WeatherDescModel],
        main: TempModel
        ) {
        self.id = id
        self.name = name
        self.weather = weather
        self.main = main
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case weather
        case main
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        weather = try container.decode([WeatherDescModel].self, forKey: .weather)
        main = try container.decode(TempModel.self, forKey: .main)
    }
}

