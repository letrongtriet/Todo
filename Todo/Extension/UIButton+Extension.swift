//
//  UIButton+Extension.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import UIKit

extension UIButton {
    func animate() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
}
