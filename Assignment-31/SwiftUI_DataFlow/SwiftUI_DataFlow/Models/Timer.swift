//
//  Timer.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 11.12.24.
//
import SwiftUI

struct TimerModel: Codable {
    var id = UUID()
    var name: String
    var duration: TimeInterval
    var defaultDuration: TimeInterval
    var isRunning: Bool = false
    var startDate: Date?
    var history: [[String: String]] = []
    
    func formatedTime(from seconds: TimeInterval) -> String {
        let totalSeconds = Int(seconds)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

