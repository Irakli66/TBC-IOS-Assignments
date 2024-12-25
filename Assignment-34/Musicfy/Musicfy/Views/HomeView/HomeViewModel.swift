//
//  HomeViewModel.swift
//  Musicfy
//
//  Created by irakli kharshiladze on 25.12.24.
//
import SwiftUI
import AVFoundation

final class HomeViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var songs: [SongModel] = []
    @Published var selectedSong: SongModel?
    @Published var currentTime: TimeInterval = 0
    @Published var isShuffleActive: Bool = false
    @AppStorage("isDarkTheme") var isDarkTheme: Bool = false
    
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    
    override init() {
        super.init()
        loadSongs()
    }
    
    func selectSong(song: SongModel) {
        stopTimer()
        currentTime = 0
        selectedSong = song
        selectedSong?.isPlaying = true
        playSelectedSong()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self,
                  let player = self.audioPlayer,
                  player.isPlaying else {
                self?.stopTimer()
                return
            }
            self.currentTime = player.currentTime
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func loadSongs() {
        let songData = [
            SongModel(songFileName: "niagara", title: "Niagara Falls", artCover: "metro2", artist: "Metro Boomin", album: "H&V"),
            SongModel(songFileName: "MyEyes", title: "My Eyes", artCover: "travis", artist: "Travis Scott", album: "Utopia"),
            SongModel(songFileName: "9", title: "9", artCover: "drake", artist: "Drake", album: "Views"),
            SongModel(songFileName: "RealFriends", title: "Real Friends", artCover: "kanye", artist: "Kanye West", album: "Life of Pablo"),
            SongModel(songFileName: "Wolves", title: "Wolves", artCover: "kanye", artist: "Kanye West", album: "Life of Pablo"),
            SongModel(songFileName: "telekinesis", title: "Telekinesis", artCover: "travis", artist: "Travis Scott", album: "Utopia"),
            SongModel(songFileName: "tvoff", title: "TV Off", artCover: "kendrick", artist: "Kendrick Lamar", album: "GNX"),
            SongModel(songFileName: "WeStillDontTrustYou", title: "We Still Don't Trust You", artCover: "metro", artist: "Metro Boomin", album: "WSDTY")
        ]
        
        for var song in songData {
            if let path = Bundle.main.path(forResource: song.songFileName, ofType: "mp3") {
                let url = URL(fileURLWithPath: path)
                do {
                    let audioPlayer = try AVAudioPlayer(contentsOf: url)
                    song.duration = audioPlayer.duration
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
            audioPlayer?.delegate = self
            audioPlayer?.play()
            selectedSong.isPlaying = true
            startTimer()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func playSong() {
        audioPlayer?.play()
        selectedSong?.isPlaying = true
        startTimer()
    }
    
    func pauseSong() {
        audioPlayer?.pause()
        selectedSong?.isPlaying = false
        stopTimer()
    }
    
    func playNextSong() {
        guard let currentSong = selectedSong else {
            return
        }
        
        if isShuffleActive {
            var randomSong: SongModel?
            repeat {
                randomSong = songs.randomElement()
            } while randomSong?.id == currentSong.id && songs.count > 1
            
            if let randomSong = randomSong {
                selectSong(song: randomSong)
            }
        } else {
            if let currentIndex = songs.firstIndex(where: { $0.id == currentSong.id }) {
                let nextIndex = (currentIndex + 1) % songs.count
                let nextSong = songs[nextIndex]
                selectSong(song: nextSong)
            }
        }
    }
    
    
    func playPreviousSong() {
        guard let currentSong = selectedSong,
              let currentIndex = songs.firstIndex(where: { $0.id == currentSong.id }) else {
            return
        }
        
        let previousIndex = (currentIndex - 1 + songs.count) % songs.count
        let previousSong = songs[previousIndex]
        selectSong(song: previousSong)
    }
    
    func formattedTime(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let remainingSeconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.stopTimer()
            self.currentTime = 0
            
            if self.selectedSong?.isLoopActive == true {
                self.playSelectedSong()
            } else {
                self.selectedSong?.isPlaying = false
                playNextSong()
            }
        }
    }
}
