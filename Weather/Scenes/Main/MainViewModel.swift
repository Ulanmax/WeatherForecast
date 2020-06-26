//
//  MainViewModel.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/25.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel: ViewModelType {
    
    struct Input {
        let cityTrigger: Driver<String>
        let countryTrigger: Driver<String>
        let addNoteTrigger: Driver<Void>
    }
    struct Output {
        let city: Driver<String>
        let country: Driver<String>
        let temperature: Driver<String>
        let weatherDescription: Driver<String>
        let recommendation: Driver<String>
        let addNote: Driver<Void>
        let fetching: Driver<Bool>
        let error: Driver<Error>
    }
    
    private let useCase: WeatherNetwork
    private let navigator: MainNavigator
    
    init(useCase: WeatherNetwork, navigator: MainNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        let weather = input.cityTrigger.flatMapLatest { city -> SharedSequence<DriverSharingStrategy, WeatherModel> in
            return self.useCase.fetchWeather(city: city)
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                }
        
        let temperature = weather.map { value -> String in
            return "\(value.main.temp)°"
        }
        
        let weatherDescription = weather.map { value -> String in
            if let weatherDescr = value.weather.first {
                return weatherDescr.main
            }
            return ""
        }
        
        let recommendation = weather.map { value -> String in
            return WeatherTypes.determineType(for: value.main.temp)
        }
        
        let addNote = input.addNoteTrigger
        .do(onNext: navigator.toAddNote)
        
        return Output(
            city: input.cityTrigger,
            country: input.countryTrigger,
            temperature: temperature,
            weatherDescription: weatherDescription,
            recommendation: recommendation,
            addNote: addNote,
            fetching: fetching,
            error: errors
        )
    }
}
