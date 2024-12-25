//
//  ManageSongCard.swift
//  Musicfy
//
//  Created by irakli kharshiladze on 25.12.24.
//
import SwiftUI

struct ManageSongCard: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Binding var isFullScreen: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if viewModel.selectedSong != nil {
                VStack {
                    HStack(spacing: 16) {
                        Image(viewModel.selectedSong?.artCover ?? "")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        VStack(alignment: .leading) {
                            Text(viewModel.selectedSong?.title ?? "")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            HStack {
                                Text(viewModel.selectedSong?.artist ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Text("•")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Text(viewModel.selectedSong?.album ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                        if viewModel.selectedSong?.isPlaying ?? true {
                            Image(systemName: "pause.fill")
                                .onTapGesture {
                                    viewModel.pauseSong()
                                }
                            
                        } else {
                            Image(systemName: "play.fill")
                                .onTapGesture {
                                    viewModel.playSong()
                                }
                        }
                    }
                    VStack {
                        HStack {
                            Text(viewModel.formattedTime(viewModel.currentTime))
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(viewModel.formattedTime(TimeInterval(viewModel.selectedSong?.duration ?? 0)))
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.secondary)
                        }
                        ProgressBar(progress: $viewModel.currentTime, duration: viewModel.selectedSong?.duration ?? 0)
                    }
                }
                .padding()
                .background(.mainBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    isFullScreen = true
                }
            } else {
                ZStack {
                    Text("Press song to play")
                        .foregroundStyle(.white)
                        .textCase(.uppercase)
                        .font(.headline)
                        .lineSpacing(20)
                }
            }
        }
        .frame(maxWidth: 380, maxHeight: 150)
        .padding()
        .background(.customShape)
    }
}
