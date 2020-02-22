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
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private var viewModel = CharacterListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Star Wars Characters"
        
        self.tableView.dataSource = viewModel
        self.tableView.delegate = self
        
        // bind elements to datasource
        self.bindView(to: viewModel)
        self.loadingIndicator.startAnimating()
        viewModel.fetchCharacters()
    }
    
    private func bindView(to viewModel: CharacterListViewModelType) {
        viewModel.output.characters.subscribe(self) { [weak self] characters in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
        
        viewModel.output.errorHandler.subscribe(self) { [weak self] error in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                self?.showAlertWithError(error)
            }
        }
        
        viewModel.output.showDetail.subscribe(self) { [weak self] character in
            self?.showCharacterDetail(character)
        }
    }
    
    private func showCharacterDetail(_ character: Character?) {
        guard let character = character, 
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CharacterDetailViewController") as? CharacterDetailViewController else {
            return
        }
        
        viewController.viewModel = CharacterDetailViewModel(character: character)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.input.tapIndex.value = indexPath
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
