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
    var characters: Observable<[Character]> { get }
    var errorHandler: Observable<Error?> { get }
}

protocol CharacterListViewModelType {
    var input: CharacterListViewModelInput { get }
    var output: CharacterListViewModelOutput { get }
    
    func fetchCharacters()
}

final class CharacterListViewModel: NSObject, CharacterListViewModelType {
    var input: CharacterListViewModelInput
    var output: CharacterListViewModelOutput
    
    private var characterFetchable: CharacterFetchable
    
    struct Input: CharacterListViewModelInput {
        var tapIndex = Observable<IndexPath?>(nil)
    }
    
    struct Output: CharacterListViewModelOutput {
        var characters = Observable<[Character]>([])
        var errorHandler = Observable<Error?>(nil)
    }
    
    init(fetchable: CharacterFetchable = CharacterFetcher()) {
        self.input = Input()
        self.output = Output()
        self.characterFetchable = fetchable
        super.init()
    }
    
    func fetchCharacters() {
        
        characterFetchable.getAllCharacters() { [weak self] result in
            switch result {
            case .failure(let error):
                self?.output.errorHandler.value = error
            case .success(var characters):
                self?.sortedCharacters(&characters)
                self?.output.characters.value = characters
            }
        }
    }
    
    func sortedCharacters(_ characters: inout [Character]) {
        characters.sort(by: { $0.name < $1.name })
    }
}
