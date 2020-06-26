//
//  AddNoteNavigator.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/26.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift

class AddNoteNavigator {

    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toMain() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}

