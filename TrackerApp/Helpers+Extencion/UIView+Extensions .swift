//
//  UIView+Extensions .swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 09.06.2024.
//

import UIKit

extension UIView {
    func addViewsTAMIC(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
