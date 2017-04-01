//
//  MovieViewController.swift
//  Flicks
//
//  Created by Krishna Alex on 3/30/17.
//  Copyright © 2017 Krishna Alex. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import FCAlertView


class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var movies: [NSDictionary] = []
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 0.14, green: 0.31, blue: 0.49, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        // add refresh control to table view
        moviesTableView.insertSubview(refreshControl, at: 0)

        loadMovie()

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ moviesTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ moviesTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        moviesTableView.rowHeight = 130
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = self.movies[indexPath.row]
        if let movieImage = movie.value(forKeyPath: "poster_path") as? String {
            let imageUrlString = "https://image.tmdb.org/t/p/w500" + (movieImage as String)
            if let imageUrl = URL(string: imageUrlString) {
                cell.movieImageView.setImageWith(imageUrl)

            }
        }
        
        if let movieLabel = movie.value(forKeyPath: "title") as? String {
            cell.movieTitleLabel?.text = movieLabel
        }
        if let movieOverview = movie.value(forKeyPath: "overview") as? String {
            cell.movieOverviewLabel?.text = movieOverview
        }
    
        return cell
    }
    
    //Remove the gray selection effect:
    func tableView(_ moviesTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesTableView.deselectRow(at: indexPath, animated:true)
    }

    //Prepare data and pass to detail screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! MovieDetailsViewController
        
        if let indexPath = moviesTableView.indexPathForSelectedRow {
            let cell = moviesTableView.cellForRow(at: indexPath) as! MovieCell
            destinationViewController.image = cell.movieImageView.image
            destinationViewController.movietitle = cell.movieTitleLabel.text!
            destinationViewController.movieoverview = cell.movieOverviewLabel.text!
            
            let movie = self.movies[indexPath.row]
            if let movieRelease = movie.value(forKeyPath: "release_date") as? String {
                destinationViewController.movierelease = movieRelease
            }
            
            print(movie.value(forKeyPath: "vote_average") as? Float ??  0)
            
            if let movieVote = movie.value(forKeyPath: "vote_average") as? Float {
                destinationViewController.movierating = movieVote
            }
            else
            {
                destinationViewController.movierating = 0
            }
            
            
        }
    }
    
    func loadMovie()
    {
        //API call
        let apikey = "api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?" + apikey)
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        //loading state while waiting for movies API
        MBProgressHUD.showAdded(to: self.view, animated: true)
        //CircularSpinner.show("Loading...", animated: true, type: .indeterminate)
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        
                        // store the returned array of movies in the movies property
                        self.movies = responseDictionary["results"] as! [NSDictionary]
                        self.moviesTableView.reloadData()
                        
                    }
                }
                if error != nil {
                    //In case of network error alert with 'Network Error' message
                    let alert = FCAlertView()
                    alert.showAlert(inView: self,
                                    withTitle: "",
                                    withSubtitle: "Network Error.",
                                    withCustomImage: nil,
                                    withDoneButtonTitle: nil,
                                    andButtons: nil)
                }
        });
        task.resume()
    }
    
    
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        loadMovie()
        refreshControl.endRefreshing()
        
    }
    
    


}


