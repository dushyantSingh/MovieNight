//
//  MovieHomeViewController.swift
//  MovieNight
//
//  Created by Dushyant Singh on 9/5/22.
//

import Foundation
import UIKit
import RxSwift

class MovieHomeViewController: UIViewController {
    var viewModel: MovieHomeViewModel!
    @IBOutlet weak var movieSearchTextField: CustomTextField!
    @IBOutlet weak var searchButton: PrimaryButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupEvents()
    }
}

private extension MovieHomeViewController {
    func setupView() {
        movieSearchTextField.title = "Movie name"
        movieSearchTextField.titleFontSize = .large
        searchButton.setTitle("Search", for: .normal)
        searchButton.rx.tap.asObservable()
            .map { [weak self] in
                return self?.movieSearchTextField.text ?? ""
            }
            .filterEmpty()
            .bind(to: viewModel.getMovies)
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
                    print(response)
                }
            })
            .disposed(by: disposeBag)
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
