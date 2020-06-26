//
//  AddNoteViewController.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/26.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class AddNoteViewController: UIViewController {
    private let disposeBag = DisposeBag()

    var viewModel: AddNoteViewModel!

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let input = AddNoteViewModel.Input(cancelTrigger: cancelButton.rx.tap.asDriver(),
                                              saveTrigger: saveButton.rx.tap.asDriver(),
                                              title: titleTextField.rx.text.orEmpty.asDriver(),
                                              details: detailsTextView.rx.text.orEmpty.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.dismiss.drive()
            .disposed(by: disposeBag)
        output.saveEnabled.drive(saveButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

