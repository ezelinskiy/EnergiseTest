//
//  TimeInterval.swift
//  EnergiseTest
//
//  Created by Evgeniy Zelinskiy on 26.04.2024.
//

import Foundation

extension TimeInterval {
    
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 100)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%02d:%02d:%02d", minutes, seconds, ms)
    }
    
}
