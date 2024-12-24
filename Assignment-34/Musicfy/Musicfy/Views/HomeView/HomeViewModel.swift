//
//  HomeViewModel.swift
//  Musicfy
//
//  Created by irakli kharshiladze on 25.12.24.
//
import SwiftUI
import AVFoundation

final class HomeViewModel: ObservableObject {
    @Published var songs: [SongModel] = []
    @Published var selectedSong: SongModel?
    @AppStorage("isDarkTheme") var isDarkTheme: Bool = false
    
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        loadSongs()
        selectedSong = songs.first
    }
    
    func selectSong(song: SongModel) {
        selectedSong = song
        selectedSong?.isPlaying = true
        playSelectedSong()
    }
    
    private func loadSongs() {
        let songData = [
            SongModel(songFileName: "MyEyes", title: "My Eyes", artCover: "travis", artist: "Travis Scott", album: "Utopia"),
            SongModel(songFileName: "RealFriends", title: "Real Friends", artCover: "kanye", artist: "Kanye West", album: "Life of Pablo"),
            SongModel(songFileName: "Wolves", title: "Wolves", artCover: "kanye", artist: "Kanye West", album: "Life of Pablo"),
            SongModel(songFileName: "WeStillDontTrustYou", title: "We Still Don't Trust You", artCover: "metro", artist: "Metro Boomin", album: "WSDTY"),
            SongModel(songFileName: "tvoff", title: "TV Off", artCover: "kendrick", artist: "Kendrick Lamar", album: "GNX")
        ]
        
        for var song in songData {
            if let path = Bundle.main.path(forResource: song.songFileName, ofType: "mp3") {
                let url = URL(fileURLWithPath: path)
                do {
                    let audioPlayer = try AVAudioPlayer(contentsOf: url)
                    song.duration = Int(audioPlayer.duration)
                } catch {
                    print("Failed to load audio file duration: \(error.localizedDescription)")
                }
            } else {
                print("Audio file not found for \(song.songFileName)")
            }
            songs.append(song)
        }
    }
    
    func playSelectedSong() {
        guard var selectedSong = selectedSong,
              let path = Bundle.main.path(forResource: selectedSong.songFileName, ofType: "mp3") else {
            print("Audio file not found.")
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            selectedSong.isPlaying = true
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func playSong() {
        audioPlayer?.play()
        selectedSong?.isPlaying = true
    }
    
    func pauseSong() {
        audioPlayer?.pause()
        selectedSong?.isPlaying = false
    }
    
    func formattedDuration(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}
