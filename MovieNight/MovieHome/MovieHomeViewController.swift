//
//  MovieHomeViewController.swift
//  MovieNight
//
//  Created by Dushyant Singh on 9/5/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MovieHomeViewController: UIViewController {
    var viewModel: MovieHomeViewModel!
    @IBOutlet weak var movieSearchTextField: CustomTextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var movieListView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var searchButton: PrimaryButton!
    @IBOutlet weak var backButton: PrimaryButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var movies = BehaviorRelay<[Movie]>(value: [])

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButtonActions()
        setupEvents()
        setupMoviesList()
        setupCollectionView()
    }
}

private extension MovieHomeViewController {
    func setupView() {
        movieListView.isHidden = true
        searchView.isHidden = false

        movieSearchTextField.title = "Movie name"
        movieSearchTextField.titleFontSize = .large
        movieTitle.font = Theme.Font.thinFont(with: 32)

        backButton.setTitle("Back", for: .normal)
        searchButton.setTitle("Search", for: .normal)
    }

    func setupButtonActions() {
        searchButton.rx.tap.asObservable()
            .map { [weak self] in
                return self?.movieSearchTextField.text ?? ""
            }
            .filterEmpty()
            .bind(to: viewModel.getMovies)
            .disposed(by: disposeBag)

        backButton.rx.tap.asObservable()
            .map { true }
            .bind(to: movieListView.rx.isHidden)
            .disposed(by: disposeBag)

        backButton.rx.tap.asObservable()
            .map { false }
            .bind(to: searchView.rx.isHidden)
            .disposed(by: disposeBag)
    }

    func setupMoviesList() {
        movies.asObservable()
            .map { $0.count == 0 }
            .bind(to: movieListView.rx.isHidden)
            .disposed(by: disposeBag)

        movies.asObservable()
            .map { $0.count != 0 }
            .bind(to: searchView.rx.isHidden)
            .disposed(by: disposeBag)
    }

    func setupEvents() {
        viewModel.events.asObservable()
            .subscribe(onNext: { [weak self] event in
                self?.activityIndicator.stopAnimating()
                switch event {
                case .loading:
                    self?.activityIndicator.startAnimating()
                case .error(let message):
                    self?.showErrorAlert(title: "Opps", message: message)
                case .displayMovies(let response):
                    self?.displayMovie(response)
                case .displayViewController(let vc):
                    self?.navigationController?
                        .pushViewController(vc,animated: true)
                }
            })
            .disposed(by: disposeBag)
    }

    func displayMovie(_ movies: [Movie]) {
        self.movies.accept(movies)
        movieTitle.text = movieSearchTextField.text
        collectionView.reloadData()
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
}

private extension MovieHomeViewController {
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCellClassForNib(cellClass: MovieCollectionViewCell.self)
    }
}

extension MovieHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return movies.value.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieCollectionViewCell.self)", for: indexPath) as? MovieCollectionViewCell
        else { return UICollectionViewCell() }

        let movie = movies.value[indexPath.row]
        cell.configure(imageURLString: movie.poster ?? "")
        return cell
    }
}

extension MovieHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let movie = movies.value[indexPath.row]
        viewModel.selectedMovie.onNext(movie)
    }
}

extension UICollectionView {
    func registerCellClassForNib(cellClass: Swift.AnyClass) {
        let identifier = "\(cellClass)"
        self.register(UINib(nibName: identifier,
                            bundle: Bundle(for: cellClass)),
                      forCellWithReuseIdentifier: identifier)
    }
}

