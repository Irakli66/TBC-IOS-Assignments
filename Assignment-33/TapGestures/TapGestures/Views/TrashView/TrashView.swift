//
//  TrashView.swift
//  TapGestures
//
//  Created by irakli kharshiladze on 18.12.24.
//
import SwiftUI
import AVFoundation

struct TrashView: View {
    @StateObject private var viewModel = TrashViewModel()
    @State private var files: [FileModel] = []
    @State private var deletedFilesCount = 0
    @State private var showDeletionCount = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Button("Spawn File") {
                    let newFile = FileModel(position: CGPoint(
                        x: CGFloat.random(in: 50...(geometry.size.width - 50)),
                        y: CGFloat.random(in: 50...(geometry.size.height - 150))
                    ))
                    
                    files.append(newFile)
                }
                .padding(10)
                .background(.purple)
                .foregroundStyle(.white)
                .cornerRadius(12)
                .position(x: geometry.size.width / 2, y: 50)
                
                Image("trashBin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .position(x: geometry.size.width - 40,
                              y: geometry.size.height - 80)
                    .onTapGesture {
                        withAnimation {
                            showDeletionCount = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showDeletionCount = false
                            }
                        }
                    }
                
                if showDeletionCount {
                    VStack {
                        Text("Deleted Files")
                            .font(.headline)
                        Text("\(deletedFilesCount)")
                            .font(.system(size: 72, weight: .bold))
                            .foregroundColor(.purple)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.9))
                            .shadow(radius: 10)
                    )
                    .transition(.scale)
                }
                
                ForEach($files) { $file in
                    Image("file")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 130)
                        .position(file.position)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    withAnimation(.smooth) {
                                        file.position = gesture.location
                                    }
                                }
                                .onEnded { gesture in
                                    let trashFrame = CGRect(
                                        x: geometry.size.width - 120,
                                        y: geometry.size.height - 150,
                                        width: 100,
                                        height: 130
                                    )
                                    
                                    if trashFrame.contains(gesture.location) {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            deletedFilesCount += 1
                                            files.removeAll { $0.id == file.id }
                                            viewModel.playTrashSound()
                                        }
                                    }
                                }
                        )
                }
            }
        }
    }
}

#Preview {
    TrashView()
}
