//
//  UIButton+Extension.swift
//  CurrencyConverterApp
//
//  Created by Ceyhun Məmmədli on 09.10.25.
//

import Foundation
import UIKit

extension UIButton {
    func animateTap(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.08,
                       animations: { self.transform = CGAffineTransform(scaleX: 0.94, y: 0.94) }) { _ in
            UIView.animate(withDuration: 0.08,
                           animations: { self.transform = .identity }) { _ in
                completion()
            }
        }
    }
}
