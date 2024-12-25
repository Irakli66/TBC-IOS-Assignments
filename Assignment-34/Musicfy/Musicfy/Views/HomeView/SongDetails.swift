//
//  SongDetails.swift
//  Musicfy
//
//  Created by irakli kharshiladze on 25.12.24.
//
import SwiftUI

struct SongDetails: View {
    @ObservedObject var viewModel: HomeViewModel
    let song: SongModel?
    @Binding var isFullScreen: Bool
    
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
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(viewModel.formattedTime(TimeInterval(viewModel.selectedSong?.duration ?? 0)))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                ZStack {
                    HStack {
                        Image(systemName: "shuffle")
                            .foregroundStyle(.customShape)
                        Spacer()
                        Image(systemName: "point.forward.to.point.capsulepath")
                            .foregroundStyle(.customShape)
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
}


//#Preview {
//    SongDetails(viewModel: HomeViewModel(), song: SongModel(songFileName: "MyEyes", title: "My Eyes", artCover: "travis", artist: "Travis Scott", album: "Utopia"), isFullScreen: .constant(true))
//}
