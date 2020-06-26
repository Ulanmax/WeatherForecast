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
        let trigger: Driver<Void>
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
        let lastNote: Driver<String>
        let fetching: Driver<Bool>
        let error: Driver<Error>
    }
    
    private let network: WeatherNetwork
    private let repo: NotesRepository
    private let navigator: MainNavigator
    
    init(network: WeatherNetwork, repo: NotesRepository, navigator: MainNavigator) {
        self.network = network
        self.repo = repo
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        let notes = input.trigger.flatMapLatest {
            return self.repo.fetchItems()
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        let lastNote = notes.map { value -> String in
            if let lastNote = value.last {
                return lastNote.body
            }
            return ""
        }
        
        let weather = input.cityTrigger.flatMapLatest { city -> SharedSequence<DriverSharingStrategy, WeatherModel> in
            return self.network.fetchWeather(city: city)
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
            lastNote: lastNote,
            fetching: fetching,
            error: errors
        )
    }
}
