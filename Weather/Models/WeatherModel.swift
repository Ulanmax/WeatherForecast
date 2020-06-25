//
//  WeatherModel.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/25.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation

public class WeatherModel: Codable {
    
    public let identifier: String
    public let name: String
    
    public init(
        identifier: String,
        name: String
        ) {
        self.identifier = identifier
        self.name = name
    }
    
    private enum CodingKeys: String, CodingKey {
        case identifier
        case name
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(String.self, forKey: .identifier)
        name = try container.decode(String.self, forKey: .name)
    }
}

