//
//  TimerViewModel.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 11.12.24.
//
import Foundation
import SwiftUI

final class TimerViewModel: ObservableObject {
    @Published var Timers: [Timer] = []
    
    init() {
        loadTimersFromUserDefaults()
    }
    
    func addTimer(name: String, hours: String, minutes: String, seconds: String) {
            let timer = Timer(name: name, hours: hours, minutes: minutes, seconds: seconds)
            Timers.append(timer)
            saveTimersToUserDefaults()
        }
    
    func removeTimer(with id: UUID) {
        Timers.removeAll(where: { $0.id == id })
        saveTimersToUserDefaults()
    }
    
    private func loadTimersFromUserDefaults() {
        if let savedData = UserDefaults.standard.data(forKey: "Timers"),
           let savedTimers = try? JSONDecoder().decode([Timer].self, from: savedData) {
            Timers = savedTimers
        }
    }
    
    private func saveTimersToUserDefaults() {
        if let encodedTimers = try? JSONEncoder().encode(Timers) {
            UserDefaults.standard.set(encodedTimers, forKey: "Timers")
        }
    }
}

