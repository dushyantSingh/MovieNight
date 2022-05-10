//
//  MovieCollectionViewCell.swift
//  MovieNight
//
//  Created by Dushyant Singh on 10/5/22.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(imageURLString: String) {
        imageView.sd_setImage(with: URL(string: imageURLString),
                              placeholderImage: UIImage(named: "movie"))
    }
}
