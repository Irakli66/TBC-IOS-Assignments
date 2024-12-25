//
//  SongView.swift
//  Musicfy
//
//  Created by irakli kharshiladze on 25.12.24.
//

import SwiftUI

struct SongView: View {
    let song: SongModel
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 16) {
                Image(song.artCover)
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack(alignment: .leading) {
                    Text(song.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    HStack {
                        Text(song.artist)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("•")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(song.album)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                VStack {
                    if viewModel.selectedSong?.id == song.id {
                        Image(systemName: "cellularbars")
                            .foregroundStyle(.green)
                    }
                    Spacer()
                }
                
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
            .background(Color.mainBackground.opacity(0.9))
            .cornerRadius(15)
            .shadow(radius: 10)
        }
    }
}
