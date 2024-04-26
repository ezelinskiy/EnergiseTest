//
//  AppHelper.swift
//  EnergiseTest
//
//  Created by Evgeniy Zelinskiy on 26.04.2024.
//

import Foundation
import StoreKit

struct AppHelper {
    
    static func rateApp() {
#if os(macOS)
        SKStoreReviewController.requestReview()
#else
        guard let scene = UIApplication.shared.foregroundActiveScene else { return }
        SKStoreReviewController.requestReview(in: scene)
#endif
    }
    
    static func openUrl(fromString urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    static func currentLocale() -> String {
        var currentLocale = "en"
        if let code = Locale.current.languageCode, code == "de" {
            currentLocale = code
        }
        return currentLocale
    }

}
