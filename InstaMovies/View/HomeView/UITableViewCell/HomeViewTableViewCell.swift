//
//  HomeViewTableViewCell.swift
//  InstaMovies
//
//  Created by Ahmed Abd Elaziz on 5/17/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class HomeViewTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var movieImage: UIImageView = {
        let movieImage = UIImageView()
        movieImage.contentMode = .scaleAspectFill
        movieImage.clipsToBounds = true
        movieImage.image = UIImage(named: "ironman")
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        return movieImage
    }()
    
    func setupMovieImageConstraints() {
        NSLayoutConstraint.activate([
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieImage.widthAnchor.constraint(equalToConstant: self.frame.width / 2.5),
            movieImage.heightAnchor.constraint(equalToConstant: self.frame.width / 1.5 - 50),
            movieImage.topAnchor.constraint(equalTo: movieTitleLabel.topAnchor),
        ])
    }
    
    lazy var movieTitleLabel: UILabel = {
        let movieTitleLabel = UILabel()
        movieTitleLabel.textColor = .darkGray
        movieTitleLabel.text = "Iron Man"
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.font = UIFont(name: "AvenirNext-Bold", size: 14)
        movieTitleLabel.textAlignment = .left
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return movieTitleLabel
    }()
    
    func setupMovieTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    lazy var movieReleaseDateLabel: UILabel = {
        let movieReleaseDateLabel = UILabel()
        movieReleaseDateLabel.textColor = .darkGray
        movieReleaseDateLabel.text = "2/9/2006"
        movieReleaseDateLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        movieReleaseDateLabel.textAlignment = .left
        movieReleaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        return movieReleaseDateLabel
    }()
    
    func setupMovieReleaseDateLabelConstraints() {
        NSLayoutConstraint.activate([
            movieReleaseDateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 8),
            movieReleaseDateLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            movieReleaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    lazy var movieOverviewLabel: UILabel = {
        let movieOverviewLabel = UILabel()
        movieOverviewLabel.textColor = .gray
        movieOverviewLabel.text = "Iron Man is a 2008 American superhero film based on the Marvel Comics character of the same name. Produced by Marvel Studios and distributed by Paramount Pictures, it is the first film in the Marvel Cinematic Universe."
        movieOverviewLabel.numberOfLines = 0
        movieOverviewLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
        movieOverviewLabel.textAlignment = .left
        movieOverviewLabel.translatesAutoresizingMaskIntoConstraints = false
        return movieOverviewLabel
    }()
    
    func setupMovieOverviewLabelConstraints() {
        NSLayoutConstraint.activate([
            movieOverviewLabel.topAnchor.constraint(equalTo: movieReleaseDateLabel.bottomAnchor, constant: 8),
            movieOverviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            movieOverviewLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            movieOverviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func addSubviews() {
        addSubview(movieImage)
        addSubview(movieTitleLabel)
        addSubview(movieReleaseDateLabel)
        addSubview(movieOverviewLabel)
    }
    
    func layoutUI() {
        addSubviews()
        setupMovieImageConstraints()
        setupMovieTitleLabelConstraints()
        setupMovieReleaseDateLabelConstraints()
        setupMovieOverviewLabelConstraints()
    }
    
    func config(_ movies: MoviesDetailsModel) {
        movieTitleLabel.text = movies.title
        movieReleaseDateLabel.text = movies.releaseDate
        movieOverviewLabel.text = movies.overview
        let movieImagesURL = NetworkConstant.photoBaseURL + (movies.posterPath ?? "Error")
        if let moviesImages = URL(string: movieImagesURL) {
            movieImage.downloaded(from: moviesImages)
        }
    }
}
