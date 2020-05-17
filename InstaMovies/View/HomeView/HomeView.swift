//
//  HomeView.swift
//  InstaMovies
//
//  Created by Ahmed Abd Elaziz on 5/17/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

class HomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var homeVC = HomeViewController()
    
    lazy var moviesTableView: UITableView = {
        let moviesTableView = UITableView()
        moviesTableView.backgroundColor = .white
        moviesTableView.rowHeight = UITableView.automaticDimension
        moviesTableView.showsVerticalScrollIndicator = false
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(HomeViewTableViewCell.self, forCellReuseIdentifier: "HomeViewTableViewCell")
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
        return moviesTableView
    }()
    
    func setupMoviesTableViewConstraints() {
        NSLayoutConstraint.activate([
            moviesTableView.topAnchor.constraint(equalTo: topAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            moviesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func addSubviews() {
        addSubview(moviesTableView)
    }
    
    func layoutUI() {
        addSubviews()
        setupMoviesTableViewConstraints()
    }
    
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVC.movies?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewTableViewCell", for: indexPath) as! HomeViewTableViewCell
        cell.config(homeVC.moviesDetails[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Movies"
    }
    
}
