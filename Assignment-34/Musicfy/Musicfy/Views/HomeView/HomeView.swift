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
                .padding(.top, 10)
                .frame(maxWidth: 380)
                
                List {
                    ForEach(viewModel.songs, id: \.self.id) { song in
                        SongView(song: song)
                            .listRowBackground(Color.clear)
                            .onTapGesture {
                                viewModel.selectSong(song: song)
                            }
                    }
                }
                .frame(maxWidth: 395)
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                
                Spacer()
                
                ManageSongCard(isFullScreen: $isFullScreen)
            }
        }
        .fullScreenCover(isPresented: $isFullScreen) {
            SongDetails(song: viewModel.selectedSong, isFullScreen: $isFullScreen)
        }
        .environmentObject(viewModel)
    }
}

//#Preview {
//    HomeView()
//}
