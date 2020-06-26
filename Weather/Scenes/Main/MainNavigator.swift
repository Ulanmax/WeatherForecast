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
    let network: NetworkProvider
    let repo: RepositoryProvider
    
    init(network: NetworkProvider,
         repo: RepositoryProvider,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.network = network
        self.repo = repo
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toMain() {
        let vc = storyBoard.instantiateViewController(ofType: MainViewController.self)
        vc.viewModel = MainViewModel(network: network.makeWeatherNetwork(), repo: repo.makeNotesRepository(),
                                        navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }

    func toAddNote() {
        let storyboard = UIStoryboard(name: "AddNote", bundle: nil)
        let navigator = AddNoteNavigator(navigationController: navigationController)
        let viewModel = AddNoteViewModel(repo: repo.makeNotesRepository(), navigator: navigator)
        let vc = storyboard.instantiateViewController(ofType: AddNoteViewController.self)
        vc.viewModel = viewModel
        let nc = UINavigationController(rootViewController: vc)
        navigationController.present(nc, animated: true, completion: nil)

    }
    
}
