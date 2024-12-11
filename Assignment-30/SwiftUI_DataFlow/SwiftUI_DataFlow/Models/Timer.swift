//
//  Timer.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 11.12.24.
//
import SwiftUI

struct Timer: Codable {
    var id = UUID()
    let name: String
    let hours: String
    let minutes: String
    let seconds: String
    
    init(name: String, hours: String = "00", minutes: String = "00", seconds: String = "00") {
        self.name = name
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}
