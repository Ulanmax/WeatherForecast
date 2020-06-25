//
//  WeatherDescModel.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/25.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation

public class WeatherDescModel: Codable {
    
    public let id: Int
    public let main: String
    
    public init(
        id: Int,
        main: String
        ) {
        self.id = id
        self.main = main
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case main
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        main = try container.decode(String.self, forKey: .main)
    }
}
