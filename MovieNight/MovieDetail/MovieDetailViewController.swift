//
//  MovieDetailViewController.swift
//  MovieNight
//
//  Created by Dushyant Singh on 10/5/22.
//

import Foundation
import UIKit
import RxSwift

class MovieDetailViewController: UIViewController {
    var viewModel: MovieDetailViewModel!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var plotDescription: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieWriter: UILabel!
    @IBOutlet weak var movieActor: UILabel!
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var directorTitle: UILabel!
    @IBOutlet weak var writerTitle: UILabel!
    @IBOutlet weak var actorTitle: UILabel!

    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieCountry: UILabel!
    @IBOutlet weak var movieAwards: UILabel!
    @IBOutlet weak var movieLanguageTitle: UILabel!
    @IBOutlet weak var movieCountryTitle: UILabel!
    @IBOutlet weak var movieAwardsTitle: UILabel!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var metaDataView: UIView!
    @IBOutlet weak var playTimeLabel: UILabel!
    @IBOutlet weak var ratingScore: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var metaScore: UILabel!
    @IBOutlet weak var metaScoreTitle: UILabel!
    @IBOutlet weak var imdbRatingTitle: UILabel!
    @IBOutlet weak var imdbRating: UILabel!

    @IBOutlet weak var plotWidth: NSLayoutConstraint!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var titleLabelWidth: NSLayoutConstraint!

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupEvents()
        displayDefaultData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchMovieDetails()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stackViewWidth.constant = scrollView.frame.width - 24
        plotWidth.constant = scrollView.frame.width - 24
        titleLabelWidth.constant = scrollView.frame.width - 24
    }
}

private extension MovieDetailViewController {
    func setupView() {
        movieTitle.font = Theme.Font.boldFont(with: 24)
        plotDescription.font = Theme.Font.thinFont(with: 18)

        movieDirector.font = Theme.Font.regularFont(with: 17)
        movieWriter.font = Theme.Font.regularFont(with: 17)
        movieActor.font = Theme.Font.regularFont(with: 17)

        directorTitle.font = Theme.Font.thinFont(with: 17)
        writerTitle.font = Theme.Font.thinFont(with: 17)
        actorTitle.font = Theme.Font.thinFont(with: 17)

        movieLanguageTitle.font = Theme.Font.thinFont(with: 17)
        movieAwardsTitle.font = Theme.Font.thinFont(with: 17)
        movieCountryTitle.font = Theme.Font.thinFont(with: 17)

        movieLanguage.font = Theme.Font.regularFont(with: 17)
        movieAwards.font = Theme.Font.regularFont(with: 17)
        movieCountry.font = Theme.Font.regularFont(with: 17)

        playTimeLabel.font = Theme.Font.thinFont(with: 17)
        releaseYear.font = Theme.Font.thinFont(with: 17)
        ratingScore.font = Theme.Font.thinFont(with: 17)

        metaScoreTitle.font = Theme.Font.thinFont(with: 17)
        imdbRatingTitle.font = Theme.Font.thinFont(with: 17)
        imdbRating.font = Theme.Font.regularFont(with: 17)
        metaScore.font = Theme.Font.regularFont(with: 17)

        plotDescription.text = ""
        movieWriter.text = ""
        movieDirector.text =  ""
        movieActor.text = ""
        releaseYear.text = ""
        ratingScore.text = ""
    }

    func setupEvents() {
        viewModel.events.asObservable()
            .subscribe(onNext: { [weak self] event in
                self?.activityIndicator.stopAnimating()
                switch event {
                case .loading:
                    self?.activityIndicator.startAnimating()
                    self?.detailStackView.isHidden = true
                    self?.metaDataView.isHidden = true
                case .error(let message):
                    self?.showErrorAlert(title: "Opps", message: message)
                case .displayMovieDetail(let response):
                    self?.setMovieDetail(detail: response)
                }
            })
            .disposed(by: disposeBag)
    }

    func setMovieDetail(detail: MovieDetail) {
        if let title = detail.title {
            movieTitle.text = title
        }
        detailStackView.isHidden = false
        plotDescription.text = detail.plot ?? ""
        movieWriter.text = detail.writer ?? ""
        movieDirector.text = detail.director ?? ""
        movieActor.text = detail.actors ?? ""
        movieAwards.text = detail.awards ?? ""
        movieCountry.text = detail.country ?? ""
        movieLanguage.text = detail.language ?? ""

        metaDataView.isHidden = false
        playTimeLabel.text = detail.runtime ?? ""
        releaseYear.text = detail.year ?? ""
        ratingScore.text = detail.rated ?? ""
        metaScore.text = detail.metascore ?? ""
        imdbRating.text = detail.imdbRating ?? ""

        imdbRatingTitle.text = "IMDb"
        metaScoreTitle.text = "Metacritic"
    }

    func showErrorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay",
                                        style: .default)
        alertController.addAction(alertAction)
        self.navigationController?.present(alertController, animated: true)
    }

    func displayDefaultData() {
        posterImageView.sd_setImage(with: URL(string: viewModel.selectedMovie.poster ?? ""),
                                    placeholderImage: UIImage(named: "movie"))
        movieTitle.text = viewModel.selectedMovie.title ?? "No Name"
    }
}
