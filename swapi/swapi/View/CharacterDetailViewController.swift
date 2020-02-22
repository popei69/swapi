//
//  CharacterDetailViewController.swift
//  swapi
//
//  Created by Benoit PASQUIER on 22/02/2020.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var viewModel: CharacterDetailViewModel!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
        self.bindView(to: viewModel)
        viewModel.fetchFilms()
    }
    
    private func setupView() {
        self.title = viewModel.output.title
        
        // set attributes
        for attributes in viewModel.output.attributes {
            stackView.addArrangedSubview(makeLabelStacked(attributes.0, value: attributes.1))
        }
        stackView.distribution = .fillEqually

        // set film tableview
        tableView.dataSource = viewModel
    }
    
    private func bindView(to viewModel: CharacterDetailViewModelType) {
        viewModel.output.films.replay(self) { [weak self] characters in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.output.errorHandler.subscribe(self) { error in
            // silent for time being
            print("Silent error on detail page: \(String(describing: error?.localizedDescription))")
        }
    }
    
    private func makeLabelStacked(_ title: String, value: String) -> UIStackView {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.text = title
        
        let valueLabel = UILabel(frame: .zero)
        valueLabel.font = UIFont.systemFont(ofSize: 14)
        valueLabel.text = value
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }
}


// MARK: - UITableViewDataSource
extension CharacterDetailViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.output.films.value.count
    }
    
    var numberOfSection: Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Appearing in movies ..."
    }   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as? FilmCell else {
            fatalError()
        }
        
        cell.film = self.output.films.value[indexPath.row]
        return cell
    }
}
