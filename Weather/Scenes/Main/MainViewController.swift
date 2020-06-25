//
//  MainViewController.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/25.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var labelReccomendation: UILabel!
    @IBOutlet weak var labelAdditional: UILabel!
    @IBOutlet weak var labelTemper: UILabel!
    @IBOutlet weak var imageViewCity: UIImageView!
    @IBOutlet weak var textViewNote: UITextView!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: MainViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.makeNavigationBarTransparent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.makeNavigationBarNonTransparent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bindViewModel()
    }
    
    private func configureUI() {
    }
    
    private func bindViewModel() {
        guard let viewModel = self.viewModel else {
            return
        }
        
        let locationTrigger = rx.sentMessage(#selector(MainViewController.changeCity(_:)))
            .map({ (value) -> String in
                return value[0] as! String
            })
        .asDriverOnErrorJustComplete()
        
        let input = MainViewModel.Input(
            trigger: locationTrigger
        )
        let output = viewModel.transform(input: input)
        
        [
            output.error.drive(errorBinding)
        ]
        .forEach({$0.disposed(by: disposeBag)})
        
    }
    
    @objc dynamic func changeCity(_ city: String) -> String {
        return city
    }
}
