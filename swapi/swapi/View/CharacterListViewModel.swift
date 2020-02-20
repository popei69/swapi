//
//  CharacterListViewModel.swift
//  swapi
//
//  Created by Benoit Pasquier on 20/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation

protocol CharacterListViewModelInput {
    var tapIndex: Observable<IndexPath?> { get set }
}

protocol CharacterListViewModelOutput {
    var characters: Observable<[Character]> { get set }
    var errorHandler: Observable<Error?> { get set }
}

protocol CharacterListViewModelType {
    var input: CharacterListViewModelInput { get }
    var output: CharacterListViewModelOutput { get }
    
    func fetchCharacters(_ fetchable: CharacterFetchable)
}

final class CharacterListViewModel: CharacterListViewModelType {
    var input: CharacterListViewModelInput
    var output: CharacterListViewModelOutput
    
    struct Input: CharacterListViewModelInput {
        var tapIndex = Observable<IndexPath?>(nil)
    }
    
    struct Output: CharacterListViewModelOutput {
        var characters = Observable<[Character]>([])
        var errorHandler = Observable<Error?>(nil)
    }
    
    init() {
        self.input = Input()
        self.output = Output()
    }
    
    func fetchCharacters(_ fetchable: CharacterFetchable) {
        
        fetchable.getCharacters(nil) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.output.errorHandler.value = error
            case .success(let response):
                self?.output.characters.value = response.results
            }
        }
    }
}
