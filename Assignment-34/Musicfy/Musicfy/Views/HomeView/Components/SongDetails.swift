//
//  SongDetails.swift
//  Musicfy
//
//  Created by irakli kharshiladze on 25.12.24.
//
import SwiftUI

struct SongDetails: View {
    @EnvironmentObject var viewModel: HomeViewModel
    let song: SongModel?
    @Binding var isFullScreen: Bool
    @State private var dragOffset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 50) {
            header
            content
            Spacer()
        }
        .padding()
        .background(.mainBackground)
    }
    
    @ViewBuilder
    private var content: some View {
        if let song = song {
            VStack(spacing: 25) {
                Image(song.artCover)
                    .resizable()
                    .frame(maxHeight: 400)
                    .cornerRadius(12)
                    .offset(x: dragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation.width
                            }
                            .onEnded { value in
                                handleSwipe(value: value)
                                withAnimation(.spring()) {
                                    dragOffset = 0
                                }
                            }
                    )
                VStack(alignment: .leading) {
                    Text(song.title)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(song.artist)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                VStack {
                    ProgressBar(progress: $viewModel.currentTime, duration: viewModel.selectedSong?.duration ?? 0)
                    HStack {
                        Text(viewModel.formattedTime(viewModel.currentTime))
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(viewModel.formattedTime(TimeInterval(viewModel.selectedSong?.duration ?? 0)))
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                    }
                }
                
                ZStack {
                    HStack {
                        Image(systemName: "shuffle")
                            .foregroundStyle(viewModel.isShuffleActive ? .green : .customShape)
                            .font(.system(size: 20))
                            .onTapGesture {
                                viewModel.isShuffleActive.toggle()
                            }
                        Spacer()
                        Image(systemName: "point.forward.to.point.capsulepath")
                            .foregroundStyle(viewModel.selectedSong?.isLoopActive ?? false ? .green : .customShape)
                            .font(.system(size: 20))
                            .onTapGesture {
                                viewModel.selectedSong?.isLoopActive.toggle()
                            }
                    }
                    HStack {
                        Image(systemName: "arrowtriangle.backward.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(.customShape)
                            .onTapGesture {
                                viewModel.playPreviousSong()
                            }
                        if viewModel.selectedSong?.isPlaying ?? false {
                            Image(systemName: "pause.fill")
                                .foregroundStyle(.mainBackground)
                                .padding(15)
                                .background(.customShape)
                                .clipShape(Circle())
                                .onTapGesture {
                                    viewModel.pauseSong()
                                }
                        } else {
                            Image(systemName: "play.fill")
                                .foregroundStyle(.mainBackground)
                                .padding(15)
                                .background(.customShape)
                                .clipShape(Circle())
                                .onTapGesture {
                                    viewModel.playSong()
                                }
                        }
                        Image(systemName: "arrowtriangle.forward.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(.customShape)
                            .onTapGesture {
                                viewModel.playNextSong()
                            }
                    }
                }
            }
            
        } else {
            Text("No song selected")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
    
    private var header: some View {
        HStack {
            Image(systemName: "chevron.down")
                .onTapGesture {
                    self.isFullScreen.toggle()
                }
            Spacer()
            Text("•••")
        }
    }
    
    private func handleSwipe(value: DragGesture.Value) {
        let horizontalTranslation = value.translation.width
        
        if horizontalTranslation < -50 {
            viewModel.playNextSong()
        } else if horizontalTranslation > 50 {
            viewModel.playPreviousSong()
        }
    }
}


//#Preview {
//    SongDetails(viewModel: HomeViewModel(), song: SongModel(songFileName: "MyEyes", title: "My Eyes", artCover: "travis", artist: "Travis Scott", album: "Utopia"), isFullScreen: .constant(true))
//}
