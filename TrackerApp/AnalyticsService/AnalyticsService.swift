//
//  AnalyticsService.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 07.06.2024.
//

import Foundation
import YandexMobileMetrica

struct AnalyticsServices{
    static func activate(){
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: "3ea9f24f-52cc-4510-b582-88ec8cdf5d5f") else { return }
        
        YMMYandexMetrica.activate(with: configuration)
    }

    static func report(event: String, screen: String, item: String? = nil) {
        var params: [String: Any] = ["event": event, "screen": screen]
        if let item = item {
            params["item"] = item
        }
        
        YMMYandexMetrica.reportEvent(event, parameters: params, onFailure: { error in
            print("REPORT ERROR: \(error.localizedDescription)")
        })
    }
}
