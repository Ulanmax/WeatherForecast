//
//  NotesRepository.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/26.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import RxSwift
import Realm
import RealmSwift

final class NotesRepository {

    private let repository: Repository<NoteModel>

    init(repository: Repository<NoteModel>) {
        self.repository = repository
    }

    public func todoItems() -> Observable<[NoteModel]> {
        return repository.queryAll()
    }
    
    public func save(todoItem: NoteModel) -> Observable<Void> {
        return repository.save(entity: todoItem)
    }

    public func delete(todoItem: NoteModel) -> Observable<Void> {
        return repository.delete(entity: todoItem)
    }
}

