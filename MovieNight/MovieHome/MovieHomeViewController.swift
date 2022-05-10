//
//  MovieHomeViewController.swift
//  MovieNight
//
//  Created by Dushyant Singh on 9/5/22.
//

import Foundation
import UIKit

class MovieHomeViewController: UIViewController {
    var viewModel: MovieHomeViewModel!
    @IBOutlet weak var movieSearchTextField: CustomTextField!
    @IBOutlet weak var searchButton: PrimaryButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.searchMovies(searchText: "Marvel")
        setupView()
    }
}

private extension MovieHomeViewController {
    func setupView() {
        movieSearchTextField.title = "Movie name"
        movieSearchTextField.titleFontSize = .large
        searchButton.setTitle("Search", for: .normal)
    }
}
