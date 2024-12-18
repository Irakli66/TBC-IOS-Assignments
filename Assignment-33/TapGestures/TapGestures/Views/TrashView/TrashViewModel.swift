//
//  TrashViewModel.swift
//  TapGestures
//
//  Created by irakli kharshiladze on 18.12.24.
//

import Foundation
import AVFoundation

final class TrashViewModel: ObservableObject {
    @Published private var audioPlayer: AVAudioPlayer?
    
    func playTrashSound() {
        guard let url = Bundle.main.url(forResource: "trashSound", withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Failed to play sound: \(error)")
        }
    }
}
