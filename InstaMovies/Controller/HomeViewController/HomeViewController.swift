//
//  ViewController.swift
//  InstaMovies
//
//  Created by Ahmed Abd Elaziz on 5/17/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var movies: MoviesModel?
    var moviesDetails = [MoviesDetailsModel]()
    let indicator = ActivityIndicator()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Home"
    }

    func fetchMoviesData() {
        indicator.setupIndicatorView(self.view, containerColor: .darkGray, indicatorColor: .white)
        let url = URL(string: NetworkConstant.baseURL)
        
        let session = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                //success
                let jsonDecoder = JSONDecoder.init()
                self.movies = try jsonDecoder.decode(MoviesModel.self, from: data!)
                self.moviesDetails = self.movies?.results ?? []
                DispatchQueue.main.async {
                    self.mainView.moviesTableView.reloadData()
                    self.indicator.hideIndicatorView(self.view)
                }
            }catch{
                //failed
                print(error.localizedDescription)
            }
        }
        session.resume()
    }

}

