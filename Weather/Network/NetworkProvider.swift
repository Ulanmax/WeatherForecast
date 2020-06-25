//
//  NetworkProvider.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/25.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

final class NetworkProvider {
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = "http://api.openweathermap.org/data/2.5"
    }
    
    public func makeWeatherNetwork() -> WeatherNetwork {
        let network = Network<WeatherModel>(apiEndpoint)
        return WeatherNetwork(network: network)
    }
}
