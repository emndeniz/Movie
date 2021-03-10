//
//  ImgeViewExtension.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 10.03.2021.
//

import UIKit


struct ImageViewHelper {
    static func createImageURL(posterPath:String) -> URL? {
        let urlStr = "https://image.tmdb.org/t/p/w200" + posterPath
        return URL(string: urlStr)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
