//
//  MovieDetailViewController.swift
//  MovieNight
//
//  Created by Dushyant Singh on 10/5/22.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var plotDescription: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieWriter: UILabel!
    @IBOutlet weak var movieActor: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension MovieHomeViewController {
    
}
