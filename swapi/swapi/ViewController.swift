//
//  ViewController.swift
//  swapi
//
//  Created by Benoit Pasquier on 19/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: CharacterListViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // bind elements to datasource
        self.bindView(to: viewModel)
        viewModel.fetchCharacters(CharacterFetcher())
    }
    
    private func bindView(to viewModel: CharacterListViewModelType) {
        viewModel.output.characters.replay(self) { characters in
            print(characters)
        }
        
        viewModel.output.errorHandler.subscribe(self) { error in
            print(error)
        }
    }
}

extension UIViewController: Identifiable {
    var id: String { return self.description }
}
