//
//  CurrencyListViewModel.swift
//  CurrencyConverterApp
//
//  Created by Ceyhun Məmmədli on 10.02.26.
//

import Foundation

class CurrencyListViewModel {
    
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
    
}
