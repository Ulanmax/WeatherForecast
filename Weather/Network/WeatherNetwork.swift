//
//  WeatherNetwork.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/25.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import RxSwift

public final class WeatherNetwork {
    private let network: Network<WeatherModel>
    
    private let path = "weather"
    
    init(network: Network<WeatherModel>) {
        self.network = network
    }
    
    public func fetchWeather(city: String) -> Observable<WeatherModel> {
        let params = ["q": city, "units": "metric"]
        return network.getItem(path, params: params).map({ (result) -> WeatherModel in
            return result
        })
    }
}
