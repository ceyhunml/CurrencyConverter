//
//  CurrencyViewController.swift
//  CurrencyConverterApp
//
//  Created by Ceyhun Məmmədli on 07.10.25.
//

import UIKit

final class CurrencyListViewController: UIViewController {
    
    var currencies = [
        "AZN", "USD", "TRY", "RUB", "EUR",
        "AED", "AFN", "ALL", "AMD", "ANG", "AOA", "ARS", "AUD", "AWG",
        "BAM", "BBD", "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BRL", "BSD", "BTN", "BWP", "BYN", "BZD",
        "CAD", "CDF", "CHF", "CLP", "CNY", "COP", "CRC", "CUP", "CVE", "CZK",
        "DJF", "DKK", "DOP", "DZD",
        "EGP", "ERN", "ETB",
        "FJD", "FKP", "FOK",
        "GBP", "GEL", "GGP", "GHS", "GIP", "GMD", "GNF", "GTQ", "GYD",
        "HKD", "HNL", "HRK", "HTG", "HUF",
        "IDR", "ILS", "IMP", "INR", "IQD", "IRR", "ISK",
        "JEP", "JMD", "JOD", "JPY",
        "KES", "KGS", "KHR", "KID", "KMF", "KRW", "KWD", "KYD", "KZT",
        "LAK", "LBP", "LKR", "LRD", "LSL", "LYD",
        "MAD", "MDL", "MGA", "MKD", "MMK", "MNT", "MOP", "MRU", "MUR", "MVR", "MWK", "MXN", "MYR", "MZN",
        "NAD", "NGN", "NIO", "NOK", "NPR", "NZD",
        "OMR",
        "PAB", "PEN", "PGK", "PHP", "PKR", "PLN", "PYG",
        "QAR",
        "RON", "RSD", "RWF",
        "SAR", "SBD", "SCR", "SDG", "SEK", "SGD", "SHP", "SLE", "SLL", "SOS", "SRD", "SSP", "STN", "SYP", "SZL",
        "THB", "TJS", "TMT", "TND", "TOP", "TTD", "TVD", "TWD", "TZS",
        "UAH", "UGX", "UYU", "UZS",
        "VES", "VND", "VUV",
        "WST",
        "XAF", "XCD", "XCG", "XDR", "XOF", "XPF",
        "YER",
        "ZAR", "ZMW", "ZWL"
    ]
    
    var filteredCurrencies = [String]()
    
    var onSelect: ((String) -> Void)?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredCurrencies = currencies
        configureUI()
    }
    
    func configureUI() {
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
            filteredCurrencies = currencies
        } else {
            filteredCurrencies = currencies.filter { $0.localizedCaseInsensitiveContains(query) }
        }
        tableView.reloadData()
    }
}


extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = filteredCurrencies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = filteredCurrencies[indexPath.row]
        onSelect?(selected)
        dismiss(animated: true)
    }
}
