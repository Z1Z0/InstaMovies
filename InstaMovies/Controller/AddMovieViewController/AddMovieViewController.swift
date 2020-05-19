//
//  AddMovieViewController.swift
//  InstaMovies
//
//  Created by Ahmed Abd Elaziz on 5/19/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class AddMovieViewController: UIViewController, dateDelegate {
    
    lazy var mainView: AddMovieView = {
        let view = AddMovieView(frame: self.view.frame)
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddMovieViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func dateChange(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        mainView.movieDate.text = dateFormatter.string(from: (mainView.datePicker?.date)!)
        view.endEditing(true)
    }
    
    
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}
