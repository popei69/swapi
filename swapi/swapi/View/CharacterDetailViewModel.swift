//
//  CharacterDetailViewModel.swift
//  swapi
//
//  Created by Benoit PASQUIER on 22/02/2020.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation

protocol CharacterDetailViewModelInput { }

protocol CharacterDetailViewModelOutput {
    var films: Observable<[Film]> { get }
    var errorHandler: Observable<Error?> { get }
    
    var title: String { get }
    var attributes: [(String, String)] { get }
}

protocol CharacterDetailViewModelType {
    var output: CharacterDetailViewModelOutput { get }
    
    func fetchFilms()
}


class CharacterDetailViewModel: NSObject, CharacterDetailViewModelType {
    
    var output: CharacterDetailViewModelOutput
    
    private var character: Character
    
    struct Output: CharacterDetailViewModelOutput {
        var films = Observable<[Film]>([])
        var errorHandler = Observable<Error?>(nil)
        
        public let title: String
        public let attributes: [(String, String)]
        
        init(_ character: Character) {
            self.title = character.name
            self.attributes = [ 
                ("Name", character.name), 
                ("Date of birth", character.birthYear),
                ("Gender", character.gender),
                ("Mass", character.mass),
                ("Height", character.height),
                ("Eye color", character.eyeColor),
                ("Hair color", character.hairColor),
                ("Skin color", character.skinColor)]
        }
    }
    
    init(character: Character) {
        self.character = character
        self.output = Output(character)
    }
    
    func fetchFilms() {
        
        // create a queue to dispatch multiple requests concurrently
        let concurrentQueue = DispatchQueue(label: "com.benoitpasquier.swapi.network", attributes: .concurrent)
        
        for filmEndpoint in character.films {
            
            concurrentQueue.async { [weak self] in
                self?.fetchFilm(filmEndpoint, completion: { result in
                    switch result {
                    case .failure(_): break
                    case .success(let newFilm):
                        print("adding new film \(newFilm)")
                        self?.output.films.value.append(newFilm)
                    }
                })
            }
        }
    }
    
    func fetchFilm(_ filmEndpoint: String, fetcher: RequestFetchable = RequestFetcher(), completion: @escaping (Result<Film, ErrorType>) -> ()) {
        
        fetcher.fetchContent(filmEndpoint, completion: completion)
    }
}
