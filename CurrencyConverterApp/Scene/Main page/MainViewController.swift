//
//  ViewController.swift
//  CurrencyConverterApp
//
//  Created by Ceyhun Məmmədli on 07.10.25.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var amountTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.placeholder = "Enter Amount"
        tf.textAlignment = .center
        tf.font = .systemFont(ofSize: 17, weight: .medium)
        tf.textColor = .systemIndigo
        tf.backgroundColor = UIColor.systemGray5
        tf.layer.cornerRadius = 16
        tf.layer.shadowColor = UIColor.black.cgColor
        tf.layer.shadowOpacity = 0.5
        tf.layer.shadowOffset = CGSize(width: 0, height: 2)
        tf.layer.shadowRadius = 8
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var resultTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Result"
        tf.textAlignment = .center
        tf.font = .systemFont(ofSize: 17, weight: .medium)
        tf.textColor = .systemTeal
        tf.backgroundColor = UIColor.systemGray5
        tf.layer.cornerRadius = 16
        tf.layer.shadowColor = UIColor.black.cgColor
        tf.layer.shadowOpacity = 0.5
        tf.layer.shadowOffset = CGSize(width: 0, height: 2)
        tf.layer.shadowRadius = 8
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    private lazy var fromButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select FROM currency ⌄", for: .normal)
        button.tintColor = .systemIndigo
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var toButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select TO currency ⌄", for: .normal)
        button.tintColor = .systemTeal
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var swapButton: UIButton = {
        var config = UIButton.Configuration.plain()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 42, weight: .bold)
        config.image = UIImage(systemName: "arrow.up.arrow.down.circle.fill", withConfiguration: imageConfig)
        config.baseForegroundColor = .systemBlue
        config.buttonSize = .large
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var exchangeButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Exchange"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .large
        config.buttonSize = .large
        config.titleTextAttributesTransformer = .init { attr in
            var attr = attr
            attr.font = .systemFont(ofSize: 20, weight: .semibold)
            return attr
        }
        let exchangeButton = UIButton(configuration: config)
        exchangeButton.layer.cornerRadius = 16
        exchangeButton.layer.shadowColor = UIColor.tintColor.cgColor
        exchangeButton.layer.shadowOpacity = 8
        exchangeButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        exchangeButton.layer.shadowRadius = 8
        exchangeButton.clipsToBounds = true
        exchangeButton.translatesAutoresizingMaskIntoConstraints = false
        return exchangeButton
    }()
    
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray6
        exchangeButton.addTarget(self, action: #selector(exchangeTapped(_:)), for: .touchUpInside)
        fromButton.addTarget(self, action: #selector(fromTapped), for: .touchUpInside)
        toButton.addTarget(self, action: #selector(toTapped), for: .touchUpInside)
        swapButton.addTarget(self, action: #selector(swapCurrencies), for: .touchUpInside)
        hideKeyboardWhenTappedAround()
        configureUI()
        doneButtonConfig()
    }
    
    private func doneButtonConfig() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        toolbar.items = [doneButton]
        amountTextField.inputAccessoryView = toolbar
    }
    
    private func parseAmount(_ text: String) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        return formatter.number(from: text)?.doubleValue
    }
    
    @objc private func doneTapped() {
        view.endEditing(true)
    }
    
    @objc private func fromTapped() {
        showCurrencySheet(for: fromButton, isFrom: true)
    }
    
    @objc private func toTapped() {
        showCurrencySheet(for: toButton, isFrom: true)
    }
    
    private func configureUI() {
        view.addSubview(amountTextField)
        view.addSubview(resultTextField)
        view.addSubview(fromButton)
        view.addSubview(swapButton)
        view.addSubview(toButton)
        view.addSubview(exchangeButton)
        
        NSLayoutConstraint.activate([
            amountTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            amountTextField.heightAnchor.constraint(equalToConstant: 60),
            
            fromButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 20),
            fromButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fromButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fromButton.heightAnchor.constraint(equalToConstant: 40),
            
            swapButton.topAnchor.constraint(equalTo: fromButton.bottomAnchor, constant: 10),
            swapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            toButton.topAnchor.constraint(equalTo: swapButton.bottomAnchor, constant: 20),
            toButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toButton.heightAnchor.constraint(equalToConstant: 40),
            
            resultTextField.topAnchor.constraint(equalTo: toButton.bottomAnchor, constant: 20),
            resultTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resultTextField.heightAnchor.constraint(equalToConstant: 60),
            
            exchangeButton.topAnchor.constraint(equalTo: resultTextField.bottomAnchor, constant: 30),
            exchangeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exchangeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            exchangeButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func showCurrencySheet(for button: UIButton, isFrom: Bool) {
        let sheetVC = CurrencyListViewController()
        sheetVC.viewModel.onSelect = { selected in
            button.setTitle(selected, for: .normal)
        }
        if let sheet = sheetVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(sheetVC, animated: true)
    }
    
    @objc private func exchangeTapped(_ sender: UIButton) {
        sender.animateTap {
            sender.configuration?.showsActivityIndicator = true
            self.performExchangeOperation()
        }
    }
    
    @objc private func swapCurrencies() {
        UIView.animate(withDuration: 0.1, animations: {
            self.swapButton.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.swapButton.transform = .identity
            })
        }
        
        if let toText = toButton.titleLabel?.text,
           let fromText = fromButton.titleLabel?.text {
            if toText.count > 3 || fromText.count > 3 {
                return
            } else {
                UIView.transition(with: view, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    let fromTitle = self.fromButton.title(for: .normal)
                    let toTitle = self.toButton.title(for: .normal)
                    
                    self.fromButton.setTitle(toTitle, for: .normal)
                    self.toButton.setTitle(fromTitle, for: .normal)
                })
            }
        }
    }
    
    @objc private func performExchangeOperation() {
        guard let amountTF = amountTextField.text,
              let from = fromButton.titleLabel?.text,
              let to = toButton.titleLabel?.text else { return }
        
        if amountTF.isEmpty || from.count > 3 || to.count > 3 {
            let alert = UIAlertController(title: "Oops!", message: "Please, fill areas before exchange.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            exchangeButton.configuration?.showsActivityIndicator = false
        } else {
            viewModel.loadCurrencyRate(of: from)
            viewModel.success = {
                guard let rate = self.viewModel.exchangeRate?.conversionRates?[to] else { return }
                
                if let amount = self.parseAmount(self.amountTextField.text ?? "") {
                    let result = amount * rate
                    DispatchQueue.main.async {
                        self.resultTextField.text = String(format: "%.2f", result)
                        self.exchangeButton.configuration?.showsActivityIndicator = false
                    }
                }
            }
        }
        viewModel.error = { message in
            print("Error:", message)
            self.exchangeButton.configuration?.showsActivityIndicator = false
        }
    }
}
