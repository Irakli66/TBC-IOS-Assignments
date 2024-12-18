//
//  SpinManager.swift
//  TapGestures
//
//  Created by irakli kharshiladze on 18.12.24.
//
import Foundation

final class WheelManager: ObservableObject {
    @Published var makeSpin: Bool = false
    @Published var isBackgroundClear: Bool = false
    
    func triggerSpin() {
        makeSpin = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.makeSpin = false
        }
    }
    
    func resetAndTriggerSpin() {
        makeSpin = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.triggerSpin()
        }
    }
}
