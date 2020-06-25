//
//  TempModel.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/25.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation

public class TempModel: Codable {
    
    public let temp: Float
    public let pressure: Int
    
    public init(
        temp: Float,
        pressure: Int
        ) {
        self.temp = temp
        self.pressure = pressure
    }
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case pressure
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        temp = try container.decode(Float.self, forKey: .temp)
        pressure = try container.decode(Int.self, forKey: .pressure)
    }
}

