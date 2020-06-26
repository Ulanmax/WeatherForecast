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
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var labelReccomendation: UILabel!
    @IBOutlet weak var labelAdditional: UILabel!
    @IBOutlet weak var labelTemper: UILabel!
    @IBOutlet weak var imageViewCity: UIImageView!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var buttonAddNote: UIButton!
    
    private let disposeBag = DisposeBag()
    
    let locationManager = CLLocationManager()
    
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
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func bindViewModel() {
        guard let viewModel = self.viewModel else {
            return
        }
        
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
        .mapToVoid()
        .asDriverOnErrorJustComplete()
        
        let cityTrigger = rx.sentMessage(#selector(MainViewController.changeCity(_:)))
            .map({ (value) -> String in
                return value[0] as! String
            })
        .asDriverOnErrorJustComplete()
        
        let countryTrigger = rx.sentMessage(#selector(MainViewController.changeCountry(_:)))
            .map({ (value) -> String in
                return value[0] as! String
            })
        .asDriverOnErrorJustComplete()
        
        let input = MainViewModel.Input(
            trigger: viewWillAppear,
            cityTrigger: cityTrigger.distinctUntilChanged(),
            countryTrigger: countryTrigger.distinctUntilChanged(),
            addNoteTrigger: buttonAddNote.rx.tap.asDriver()
        )
        let output = viewModel.transform(input: input)
        
        [
            output.error.drive(errorBinding),
            output.fetching.drive(fetchingBinding),
            output.city.drive(onNext: { [weak self] (value) in
                self?.labelCity.text = value
            }),
            output.country.drive(onNext: { [weak self] (value) in
                self?.labelCountry.text = value
            }),
            output.temperature.drive(onNext: { [weak self] (value) in
                self?.labelTemper.text = value
            }),
            output.weatherDescription.drive(onNext: { [weak self] (value) in
                self?.labelAdditional.text = value
            }),
            output.recommendation.drive(onNext: { [weak self] (value) in
                self?.labelReccomendation.text = value
            }),
            output.addNote.drive(),
            output.lastNote.drive(onNext: { [weak self] (value) in
                self?.labelNote.text = value
            }),
        ]
        .forEach({$0.disposed(by: disposeBag)})
        
    }
    
    @objc dynamic func changeCity(_ city: String) -> String {
        return city
    }
    
    @objc dynamic func changeCountry(_ country: String) -> String {
        return country
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocation = manager.location else { return }
        locValue.fetchCityAndCountry { [weak self] city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            let _ = self?.changeCity(city)
            let _ = self?.changeCountry(country)
        }
    }
}
