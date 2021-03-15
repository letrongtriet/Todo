//
//  Identifier.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import UIKit

protocol Identifiable {
    static func identifier() -> String
}

extension Identifiable {
    static func identifier() -> String {
        String(describing: self)
    }
}

extension UICollectionViewCell: Identifiable {}
extension UIViewController: Identifiable {}
extension UITableViewHeaderFooterView: Identifiable {}
extension UITableViewCell: Identifiable {}
