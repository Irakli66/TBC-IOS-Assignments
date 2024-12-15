//
//  TimerDetailsViewModel.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 15.12.24.
//
import Foundation

final class TimerDetailsViewModel: ObservableObject {
    
    func calculateTodaysStatistics(for timer: TimerModel) -> SessionStatistics {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ka_GE")
        dateFormatter.dateFormat = "dd MMM yyyy"
        let today = dateFormatter.string(from: Date())
        
        guard let todayHistory = timer.history.first(where: { $0.date == today }) else {
            return SessionStatistics(sessionCount: 0, totalLength: 0, averageLength: 0)
        }
        
        let sessionCount = todayHistory.sessions.count
        
        let allSessions = timer.history.flatMap { $0.sessions }
        let totalDurationAllDays = allSessions.reduce(0) { $0 + $1.duration }
        let averageDurationAllDays = allSessions.isEmpty ? 0 : totalDurationAllDays / Double(allSessions.count)
        
        return SessionStatistics(sessionCount: sessionCount, totalLength: totalDurationAllDays, averageLength: averageDurationAllDays)
    }
}
