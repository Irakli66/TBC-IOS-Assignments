//
//  RotateManager.swift
//  TapGestures
//
//  Created by irakli kharshiladze on 18.12.24.
//
import Foundation

final class RotateManager: ObservableObject {
    @Published var shouldRotate = false
    
    func doRotate() {
        shouldRotate.toggle()
    }
}
