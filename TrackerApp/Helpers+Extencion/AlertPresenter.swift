//
//  AlertPresenter.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 09.06.2024.
//

import UIKit

struct AlertModel {
    var title: String?
    var message: String?
    var buttonText: String
    var completion: ((UIAlertAction) -> Void)?
    var cancelText: String
    var cancelCompletion: ((UIAlertAction) -> Void)?
}

final class AlertPresenter {
    func show(controller: UIViewController?, model: AlertModel) {
        let alert = UIAlertController(title: model.title,
                                      message: model.message,
                                      preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: model.buttonText,
                                   style: .destructive,
                                   handler: model.completion)
        
        let cancelAction = UIAlertAction(title: model.cancelText,
                                         style: .cancel,
                                         handler: model.cancelCompletion)
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        controller?.present(alert, animated: true)
    }
}
