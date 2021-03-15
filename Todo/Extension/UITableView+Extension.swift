//
//  UITableView+Extension.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import UIKit

extension UITableView {
    func reloadDataAnimated() {
        UIView.transition(with: self,
                          duration: 0.25,
                          options: [.beginFromCurrentState, .transitionCrossDissolve],
                          animations: { self.reloadData() },
                          completion: nil)
    }

    func dequeueReusableCell<T: UITableViewCell>(
        withIdentifier identifier: String = T.identifier(),
        for indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T
        else {
            fatalError("Unable to dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
}
