//
//  SongModel.swift
//  Musicfy
//
//  Created by irakli kharshiladze on 25.12.24.
//
import Foundation

struct SongModel {
    let id: UUID = UUID()
    let songFileName: String
    let title: String
    let artCover: String
    let artist: String
    let album: String
    var duration: Int = 0
    var isPlaying: Bool = false
}
