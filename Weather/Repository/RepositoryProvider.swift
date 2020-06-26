//
//  RepositoryProvider.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/26.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Realm
import RealmSwift

final class RepositoryProvider {
    
    private let configuration: Realm.Configuration

    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
    }

    public func makeNotesRepository() -> NotesRepository {
        let repository = Repository<NoteModel>(configuration: configuration)
        return NotesRepository(repository: repository)
    }
}
