//
//  AddNoteViewModel.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/26.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class AddNoteViewModel: ViewModelType {
    private let repo: NotesRepository
    private let navigator: AddNoteNavigator

    init(repo: NotesRepository, navigator: AddNoteNavigator) {
        self.repo = repo
        self.navigator = navigator
    }

    func transform(input: Input) -> Output {
        let titleAndDetails = Driver.combineLatest(input.title, input.details)
        let activityIndicator = ActivityIndicator()

        let canSave = Driver.combineLatest(titleAndDetails, activityIndicator.asDriver()) {
            return !$0.0.isEmpty && !$0.1.isEmpty && !$1
        }

        let save = input.saveTrigger.withLatestFrom(titleAndDetails)
                .map { (title, content) in
                    return NoteModel(body: content, title: title)
                }
                .flatMapLatest { [unowned self] in
                    return self.repo.save(todoItem: $0)
                            .trackActivity(activityIndicator)
                            .asDriverOnErrorJustComplete()
                }

        let dismiss = Driver.of(save, input.cancelTrigger)
                .merge()
                .do(onNext: navigator.toMain)

        return Output(dismiss: dismiss, saveEnabled: canSave)
    }
}

extension AddNoteViewModel {
    struct Input {
        let cancelTrigger: Driver<Void>
        let saveTrigger: Driver<Void>
        let title: Driver<String>
        let details: Driver<String>
    }

    struct Output {
        let dismiss: Driver<Void>
        let saveEnabled: Driver<Bool>
    }
}
