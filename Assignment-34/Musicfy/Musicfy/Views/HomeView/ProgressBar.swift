//
//  ProgressBar.swift
//  Musicfy
//
//  Created by irakli kharshiladze on 25.12.24.
//
import SwiftUI

struct ProgressBar: UIViewRepresentable {
    @Binding var progress: TimeInterval
    let duration: TimeInterval
    
    func makeUIView(context: Context) -> UIProgressView {
        let progressBar = UIProgressView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        progressBar.progress = 0.0
        progressBar.progressViewStyle = .bar
        progressBar.progressTintColor = UIColor(named: "customShape")
        progressBar.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return progressBar
    }
    
    func updateUIView(_ progressView: UIProgressView, context: Context) {
        let normalizedProgress = duration > 0 ? Float(progress / duration) : 0
        progressView.setProgress(normalizedProgress, animated: true)
    }
}
