//
//  ViewController.swift
//  swapi
//
//  Created by Benoit Pasquier on 19/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = CharacterListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        self.tableView.dataSource = viewModel
        
        // bind elements to datasource
        self.bindView(to: viewModel)
        viewModel.fetchCharacters(CharacterFetcher())
    }
    
    private func bindView(to viewModel: CharacterListViewModelType) {
        viewModel.output.characters.replay(self) { [weak self] characters in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.output.errorHandler.subscribe(self) { error in
            print(error)
        }
    }
}

// MARK: - UITableViewDataSource
extension CharacterListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.output.characters.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
        
        let character = self.output.characters.value[indexPath.row]
        cell.textLabel?.text = character.name
        return cell
    }
}


extension UIViewController: Identifiable {
    var id: String { return self.description }
}
