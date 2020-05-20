//
//  AddMovieViewController.swift
//  InstaMovies
//
//  Created by Ahmed Abd Elaziz on 5/19/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

@objc protocol AddingMovieDelegate: class {
    @objc func addMovies(movieTitle: String, movieOverview: String, movieDate: String, movieImage: UIImage)
}

class AddMovieViewController: UIViewController, MovieDelegate {
    
    weak var addingDelegate: AddingMovieDelegate?
    
    lazy var mainView: AddMovieView = {
        let view = AddMovieView(frame: self.view.frame)
        view.backgroundColor = .white
        view.delegate = self
        view.addingMovieVC = self
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
        mainView.submitMovieButton.addTarget(self, action: #selector(addingMovieAction), for: .touchUpInside)
    }
    
    @objc func addingMovieAction() {
        addingDelegate?.addMovies(movieTitle: mainView.movieTitle.text!,
                                  movieOverview: mainView.movieOverview.text!,
                                  movieDate: mainView.movieDate.text!,
                                  movieImage: mainView.movieImage.image!)
        self.dismiss(animated: true, completion: nil)
    }
    
    func dateChange(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        mainView.movieDate.text = dateFormatter.string(from: (mainView.datePicker?.date)!)
        view.endEditing(true)
    }
}

extension AddMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func movieImageTapped() {
        showImagePickerControllerActionSheet()
    }
    
    func showImagePickerControllerActionSheet() {
        let photoLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        AlertService.showAlert(style: .actionSheet, title: "Choose movie image", message: nil, actions: [photoLibraryAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            mainView.movieImage.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            mainView.movieImage.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}
