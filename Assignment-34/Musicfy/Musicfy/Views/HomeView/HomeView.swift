//
//  HomeView.swift
//  Musicfy
//
//  Created by irakli kharshiladze on 24.12.24.
//
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var isFullScreen = false
    
    var body: some View {
        ZStack {
            Color.mainBackground
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.customShape)
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            VStack {
                HStack {
                    Spacer()
                    Text("Musicfy")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                    Toggle(isOn: $viewModel.isDarkTheme){
                        
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color.mainBackground))
                }
                .frame(maxWidth: 380)
                
                List {
                    ForEach(viewModel.songs, id: \.self.id) { song in
                        SongView(song: song, viewModel: viewModel)
                        .listRowBackground(Color.clear)
                        .onTapGesture {
                            viewModel.selectSong(song: song)
                        }
                    }
                }
                .frame(maxWidth: 400)
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
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
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(viewModel.formattedTime(TimeInterval(viewModel.selectedSong?.duration ?? 0)))
                                    .font(.caption)
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
                }
                .frame(maxWidth: 380)
                .padding()
                .background(.customShape)
            }
        }
    }
}


#Preview {
    HomeView()
}
