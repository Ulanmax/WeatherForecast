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

    func toAddNote() {
//        let storyboard = UIStoryboard(name: "AddNote", bundle: nil)
//
//        let mainNavigator = MainNavigator(services: networkUseCaseProvider,
//                                                         navigationController: navigationController,
//                                                         storyBoard: storyboard)
//        let vc = UIViewController()
//        
//        vc.view.backgroundColor = .blue
//        
//        mainNavigator.toMain()
    }
    
}
