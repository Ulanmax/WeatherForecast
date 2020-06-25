//
//  MainNavigator.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/25.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift

class MainNavigator {
    
    let storyBoard: UIStoryboard
    let navigationController: UINavigationController
    let services: NetworkProvider
    
    init(services: NetworkProvider,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toMain() {
        let vc = storyBoard.instantiateViewController(ofType: MainViewController.self)
        vc.viewModel = MainViewModel(useCase: services.makeWeatherNetwork(),
                                        navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
//
//    func toRegionDetails(_ region: RegionModel) {
//        let viewModel = RegionDetailsViewModel(useCase: services.makeRegionsNetwork(), navigator: self, region: region)
//        let vc = storyBoard.instantiateViewController(ofType: RegionDetailsViewController.self)
//        vc.viewModel = viewModel
//        navigationController.pushViewController(vc, animated: true)
//    }
    
}
