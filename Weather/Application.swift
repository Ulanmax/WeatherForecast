//
//  Application.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/25.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import Foundation

final class Application {
    static let shared = Application()

    private let networkUseCaseProvider: NetworkProvider
    
    private let repositoryProvider: RepositoryProvider
    
    var window: UIWindow?
    
    private init() {
        self.networkUseCaseProvider = NetworkProvider()
        self.repositoryProvider = RepositoryProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        
        self.updateApperance()
        
        self.window = window
        
        openMainInterface()
    }
    
    func openMainInterface() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigationController = UINavigationController()

        let mainNavigator = MainNavigator(network: networkUseCaseProvider,
                                          repo: repositoryProvider,
                                                         navigationController: navigationController,
                                                         storyBoard: storyboard)
        let vc = UIViewController()
        
        vc.view.backgroundColor = .blue
        
        mainNavigator.toMain()

        window?.rootViewController = navigationController
    }
    
    func updateApperance() {
        
    }
}
