//
//  TimerViewModel.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 11.12.24.
//
import SwiftUI
import Combine
import AVFoundation
import AudioToolbox

final class TimerViewModel: ObservableObject {
    @Published var timers: [TimerModel] = []
    @AppStorage("Timers") private var storedTimersData: Data?
    
    private var timerCancellables: [UUID: AnyCancellable] = [:]
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        loadTimersFromAppStorage()
    }
    
    func addTimer(name: String, hours: String, minutes: String, seconds: String) {
        let hoursValue = Int(hours) ?? 0
        let minutesValue = Int(minutes) ?? 0
        let secondsValue = Int(seconds) ?? 0
        
        let totalInterval = hoursValue * 3600 + minutesValue * 60 + secondsValue
        guard totalInterval > 0 else {
            print("Cannot add a timer with zero duration.")
            return
        }
        
        let timer = TimerModel(name: name, duration: TimeInterval(totalInterval), defaultDuration: TimeInterval(totalInterval))
        timers.append(timer)
        saveTimersToAppStorage()
    }
    
    func removeTimer(with id: UUID) {
        timers.removeAll(where: { $0.id == id })
        saveTimersToAppStorage()
    }
    
    func startTimer(with timer: TimerModel) {
        guard let index = timers.firstIndex(where: { $0.id == timer.id }) else { return }
        timers[index].isRunning = true
        timers[index].startDate = Date()
        
        if timers[index].duration == 0 {
            timers[index].duration = timer.defaultDuration
        }
        
        timerCancellables[timer.id]?.cancel()
        timerCancellables[timer.id] = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                if self?.timers[index].duration ?? 0 > 0 {
                    self?.timers[index].duration -= 1
                } else {
                    self?.playEndSounAndVibrate()
                    self?.resetTimer(with: timer)
                }
            }
    }
    
    func pauseTimer(with timer: TimerModel) {
        guard let index = timers.firstIndex(where: { $0.id == timer.id }) else { return }
        timers[index].isRunning = false
        
        updateHistory(for: &timers[index])
        
        timerCancellables[timer.id]?.cancel()
        timerCancellables[timer.id] = nil
    }
    
    func resetTimer(with timer: TimerModel) {
        guard let index = timers.firstIndex(where: { $0.id == timer.id }) else { return }
        timers[index].isRunning = false
        
        updateHistory(for: &timers[index])
        
        timerCancellables[timer.id]?.cancel()
        timerCancellables[timer.id] = nil
        timers[index].duration = timer.defaultDuration
    }
    
    private func updateHistory(for timer: inout TimerModel) {
        guard let startDate = timer.startDate else { return }
        let elapsed = Date().timeIntervalSince(startDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ka_GE")
        dateFormatter.dateFormat = "dd MMM yyyy"
        let today = dateFormatter.string(from: Date())
        
        if let index = timer.history.firstIndex(where: { $0["date"] == today }) {
            if let previousTimeUsed = Int(timer.history[index]["timeUsed"] ?? "0") {
                let updatedTimeUsed = previousTimeUsed + Int(elapsed) - 1
                timer.history[index]["timeUsed"] = "\(updatedTimeUsed)"
            }
        } else {
            let newEntry: [String: String] = [
                "date": today,
                "timeUsed": "\(Int(elapsed - 1))"
            ]
            timer.history.append(newEntry)
        }
        
        timer.startDate = nil
        if let timerIndex = timers.firstIndex(where: { $0.id == timer.id }) {
            timers[timerIndex] = timer
            timers[timerIndex].duration = timer.defaultDuration
            saveTimersToAppStorage()
        }
    }
    
    
    func playEndSounAndVibrate() {
        guard let url = Bundle.main.url(forResource: "timerEnd", withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Failed to play sound: \(error)")
        }
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    private func loadTimersFromAppStorage() {
        if let savedData = storedTimersData,
           let savedTimers = try? JSONDecoder().decode([TimerModel].self, from: savedData) {
            timers = savedTimers
        }
    }
    
    private func saveTimersToAppStorage() {
        if let encodedTimers = try? JSONEncoder().encode(timers) {
            storedTimersData = encodedTimers
        }
    }
}
