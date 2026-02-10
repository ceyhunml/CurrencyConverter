//
//  CurrencyViewController.swift
//  CurrencyConverterApp
//
//  Created by Ceyhun Məmmədli on 07.10.25.
//

import UIKit

final class CurrencyListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var searchBar: UISearchBar = {
        let b = UISearchBar()
        b.placeholder = "Search currency"
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let viewModel = CurrencyListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.filteredCurrencies = viewModel.currencies
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        searchBar.searchTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 2),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func textChanged() {
        let query = searchBar.searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if query.isEmpty {
            viewModel.filteredCurrencies = viewModel.currencies
        } else {
            viewModel.filteredCurrencies = viewModel.currencies.filter { $0.localizedCaseInsensitiveContains(query) }
        }
        tableView.reloadData()
    }
}


extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.filteredCurrencies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = viewModel.filteredCurrencies[indexPath.row]
        viewModel.onSelect?(selected)
        dismiss(animated: true)
    }
}
