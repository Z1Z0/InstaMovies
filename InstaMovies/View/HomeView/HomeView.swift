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
        moviesTableView.prefetchDataSource = self
        moviesTableView.registerCell(cellClass: HomeViewTableViewCell.self)
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

extension HomeView: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return homeVC.moviesTitle.count
        case 1:
            return homeVC.movies?.results?.count ?? 0
        default:
            return homeVC.movies?.results?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeue() as HomeViewTableViewCell
            cell.movieTitleLabel.text = homeVC.moviesTitle[indexPath.row]
            cell.movieOverviewLabel.text = homeVC.moviesOverview[indexPath.row]
            cell.movieReleaseDateLabel.text = homeVC.moviesDate[indexPath.row]
            cell.movieImage.image = homeVC.moviesImage[indexPath.row]
            return cell
        case 1:
            let cell = tableView.dequeue() as HomeViewTableViewCell
            cell.config(homeVC.moviesDetails[indexPath.row])
            return cell
        default:
            let cell = tableView.dequeue() as HomeViewTableViewCell
            cell.config(homeVC.moviesDetails[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "All Movies"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for index in indexPaths {
            if index.row >= homeVC.moviesDetails.count - 1 && !homeVC.isFetchingMovies {
                homeVC.currentPage += 1
                homeVC.fetchMoviesData()
                DispatchQueue.main.async {
                    self.moviesTableView.reloadData()
                }
                break
            }
        }
    }
    
}
