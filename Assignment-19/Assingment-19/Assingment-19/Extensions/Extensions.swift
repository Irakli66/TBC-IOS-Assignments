//
//  ImageViewExtension.swift
//  Assingment-19
//
//  Created by irakli kharshiladze on 30.10.24.
//

import Foundation
import UIKit

extension UIImageView{
    func imageFrom(url:URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data:data){
                    DispatchQueue.main.async{
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UILabel {
    func configureLabel(text: String, font: UIFont, textColor: UIColor, alignment: NSTextAlignment, numberOfLines: Int = 1) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
}

extension String {
    func formattedDate(from inputFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ", to outputFormat: String = "EEEE, d MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        guard let date = dateFormatter.date(from: self) else {
            return "Unknown Date"
        }
        
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date)
    }
}
