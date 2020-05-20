//
//  ViewController.swift
//  InstaMovies
//
//  Created by Ahmed Abd Elaziz on 5/17/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, AddingMovieDelegate {

    var movies: MoviesModel?
    var moviesDetails = [MoviesDetailsModel]()
    let indicator = ActivityIndicator()
    var currentPage: Int = 1
    var moviesTitle = [String]()
    var moviesOverview = [String]()
    var moviesDate = [String]()
    var moviesImage = [UIImage]()
    var isFetchingMovies = false
    
    lazy var mainView: HomeView = {
        let view = HomeView(frame: self.view.frame)
        view.backgroundColor = .white
        view.homeVC = self
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchMoviesData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovie))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Home"
        
    }

    func fetchMoviesData() {
        isFetchingMovies = true
        indicator.setupIndicatorView(self.view, containerColor: .darkGray, indicatorColor: .white)
        let url = URL(string: "http://api.themoviedb.org/3/discover/movie?api_key=a5e746e272891f2d149d513be046dabc&page=\(currentPage)")
        
        let session = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                //success
                let jsonDecoder = JSONDecoder.init()
                self.movies = try jsonDecoder.decode(MoviesModel.self, from: data!)
                self.moviesDetails += self.movies?.results ?? []
//                self.moviesDetails.append(contentsOf: self.movies?.results ?? [])
                print(self.currentPage)
                DispatchQueue.main.async {
                    self.mainView.moviesTableView.reloadData()
                    self.indicator.hideIndicatorView(self.view)
                }
                
                self.isFetchingMovies = false
            }catch{
                //failed
                DispatchQueue.main.async {
                    self.indicator.hideIndicatorView(self.view)
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Close", style: .destructive, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        session.resume()
    }
    
    @objc func addMovie() {
        let addMovieVC = AddMovieViewController()
        addMovieVC.addingDelegate = self
        self.present(addMovieVC, animated: true, completion: nil)
    }
    
    func addMovies(movieTitle: String, movieOverview: String, movieDate: String, movieImage: UIImage) {
        moviesTitle.append(movieTitle)
        moviesOverview.append(movieOverview)
        moviesDate.append(movieDate)
        moviesImage.append(movieImage)
        DispatchQueue.main.async {
            self.mainView.moviesTableView.reloadData()
        }
    }
    
}

