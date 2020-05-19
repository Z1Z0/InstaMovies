//
//  AddMovieView.swift
//  InstaMovies
//
//  Created by Ahmed Abd Elaziz on 5/19/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

@objc protocol dateDelegate: class {
    @objc func dateChange(datePicker: UIDatePicker)
}

class AddMovieView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var datePicker: UIDatePicker?
    weak var delegate: dateDelegate?
    
    lazy var movieImageButton: UIButton = {
        let movieImageButton = UIButton()
        movieImageButton.setTitle("", for: .normal)
        movieImageButton.translatesAutoresizingMaskIntoConstraints = false
        movieImageButton.backgroundColor = .clear
        movieImageButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        movieImageButton.layer.cornerRadius = frame.width / 7
        movieImageButton.layer.masksToBounds = true
        return movieImageButton
    }()
    
    @objc func add() {
        print("Hello")
    }
    
    func setupMovieImageButtonConstaints() {
        NSLayoutConstraint.activate([
            movieImageButton.heightAnchor.constraint(equalToConstant: frame.width / 3.5),
            movieImageButton.widthAnchor.constraint(equalToConstant: frame.width / 3.5),
            movieImageButton.centerXAnchor.constraint(equalTo: movieImage.centerXAnchor),
            movieImageButton.centerYAnchor.constraint(equalTo: movieImage.centerYAnchor)
        ])
    }
    
    lazy var movieImage: UIImageView = {
        let movieImage = UIImageView()
        movieImage.contentMode = .scaleToFill
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 0, weight: .thin, scale: .small)
        movieImage.image = UIImage(systemName: "plus.circle", withConfiguration: imageConfig)
        movieImage.tintColor = .darkGray
        movieImage.layer.cornerRadius = frame.width / 7
        movieImage.layer.masksToBounds = true
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        return movieImage
    }()
    
    func setupMovieImageConstraints() {
        NSLayoutConstraint.activate([
            movieImage.heightAnchor.constraint(equalToConstant: frame.width / 3.5),
            movieImage.widthAnchor.constraint(equalToConstant: frame.width / 3.5),
            movieImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            movieImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    lazy var movieTitle: UITextField = {
        let movieTitle = UITextField()
        movieTitle.attributedPlaceholder = NSAttributedString(string: "Enter movie name", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        movieTitle.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        movieTitle.backgroundColor = .white
        movieTitle.borderStyle = .roundedRect
        movieTitle.layer.borderColor = UIColor.lightGray.cgColor
        movieTitle.layer.borderWidth = 1.0
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        return movieTitle
    }()
    
    func setupMovieTitleConstraints() {
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 16),
            movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    lazy var movieOverview: UITextView = {
        let movieOverview = UITextView()
        movieOverview.text = "Enter movie overview"
        movieOverview.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        movieOverview.textColor = .lightGray
        movieOverview.layer.borderColor = UIColor.lightGray.cgColor
        movieOverview.layer.borderWidth = 1.0
        movieOverview.backgroundColor = .white
        movieOverview.layer.cornerRadius = 8.0
        movieOverview.delegate = self
        movieOverview.textContainerInset = UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        return movieOverview
    }()
    
    func setupMovieOverviewConstraints() {
        NSLayoutConstraint.activate([
            movieOverview.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 16),
            movieOverview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieOverview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            movieOverview.heightAnchor.constraint(equalToConstant: self.frame.height / 3)
        ])
    }
    
    lazy var movieDate: UITextField = {
        let movieDate = UITextField()
        movieDate.attributedPlaceholder = NSAttributedString(string: "Choose movie date", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        movieDate.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        movieDate.backgroundColor = .white
        movieDate.borderStyle = .roundedRect
        movieDate.layer.borderColor = UIColor.lightGray.cgColor
        movieDate.layer.borderWidth = 1.0
        self.datePicker = UIDatePicker()
        self.datePicker?.datePickerMode = .date
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.year = 0
        let maxDate = calendar.date(byAdding: comps, to: Date())
        comps.year = -30
        let minDate = calendar.date(byAdding: comps, to: Date())
        self.datePicker?.maximumDate = maxDate
        self.datePicker?.minimumDate = minDate
        movieDate.inputView = self.datePicker
        self.datePicker?.addTarget(delegate, action: #selector(delegate?.dateChange(datePicker:)), for: .valueChanged)
        movieDate.translatesAutoresizingMaskIntoConstraints = false
        return movieDate
    }()
    
    func setupMovieDateConstraints() {
        NSLayoutConstraint.activate([
            movieDate.topAnchor.constraint(equalTo: movieOverview.bottomAnchor, constant: 16),
            movieDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func addSubviews() {
        addSubview(movieImageButton)
        addSubview(movieImage)
        addSubview(movieTitle)
        addSubview(movieOverview)
        addSubview(movieDate)
    }
    
    func layoutUI() {
        addSubviews()
        setupMovieImageButtonConstaints()
        setupMovieImageConstraints()
        setupMovieTitleConstraints()
        setupMovieOverviewConstraints()
        setupMovieDateConstraints()
    }
    
}

extension AddMovieView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.darkGray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter movie overview"
            textView.textColor = UIColor.lightGray
        }
    }
    
}
