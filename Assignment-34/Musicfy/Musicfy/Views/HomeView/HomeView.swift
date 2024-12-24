//
//  HomeView.swift
//  Musicfy
//
//  Created by irakli kharshiladze on 24.12.24.
//
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var isSheetPresented: Bool = false
    
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
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                }
                .frame(maxWidth: 380)
                List {
                    ForEach(viewModel.songs, id: \.self.id) { song in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 16) {
                                Image(song.artCover)
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                VStack(alignment: .leading) {
                                    Text(song.title)
                                        .font(.headline)
                                        .foregroundColor( viewModel.selectedSong?.id == song.id ? .green : .primary)
                                    
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
                                    Text(viewModel.formattedDuration(song.duration))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                               
                            }
                            .padding(.vertical, 15)
                            .padding(.horizontal, 10)
                            .background(Color.mainBackground.opacity(0.9))
                            .cornerRadius(15)
                            .shadow(radius: 10)
                        }
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
                    .padding()
                    .background(.mainBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        isSheetPresented = true
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
