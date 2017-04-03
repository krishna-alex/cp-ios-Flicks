//
//  MovieListViewController.swift
//  Flicks
//
//  Created by Krishna Alex on 4/2/17.
//  Copyright © 2017 Krishna Alex. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import FCAlertView

class MovieListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    private var _prototypeCell: MovieTableViewCell?
    
    private var prototypeCell: MovieTableViewCell {
        if (!(self._prototypeCell != nil)) {
            self._prototypeCell = self.moviesTableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell
        }
        return self._prototypeCell!
    }
    
    @IBOutlet weak var moviesTableView: UITableView!
    //@IBOutlet weak var searchBar: UISearchBar!
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x:0,y:0,width:200,height:200))

    
    var movies: [NSDictionary] = []
    var searchActive : Bool = false
    var filteredMovies:[NSDictionary] = []
    var Data:[String] = []
//    var valueToPass: NSDictionary!
    
    enum controllerTypes: String {
        case nowPlaying = "now_playing"
        case topRated = "top_rated"
    }
    
    var controllerType: controllerTypes?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        //set Navigation bar title and color
        
        navigationItem.title = "Flicks"
        
        searchBar.placeholder = "Your placeholder"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        
        //let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        //self.view.addSubview(navBar);
        //let navItem = UINavigationItem();
        //let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(getter: UIAccessibilityCustomAction.selector));
        //navItem.rightBarButtonItem = doneItem;
 //       self.navigationItem.titleView = self.searchBar;
        
//        var leftNavBarButton = UIBarButtonItem(customView:self.searchBar)
//        self.navigationController?.navigationBar.setItems([leftNavBarButton], animated: false);
        
  //     self.navigationItem.titleView = self.searchBar;
    //    self.tabBarItem. = self.searchBar;

//        navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 0.14, green: 0.31, blue: 0.49, alpha: 1.0)
//        navigationController?.navigationBar.barStyle = UIBarStyle.black
//        //navigationController?.navigationBar.setBackgroundImage(UIImage(named: "Icon-60@2x.png"), for: .default)
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        searchBar.delegate = self
//        
//        var searchBar:UISearchBar = UISearchBar(frame: CGRect(x:0,y:0,width:200,height:200))
//        
//        navigationItem.titleView = searchBar;
//        searchBar.delegate = self
//        
        
        let tableViewNib: UINib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        self.moviesTableView.register(tableViewNib, forCellReuseIdentifier: "MovieTableViewCell")
        
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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchActive = (searchText.characters.count > 0)
        if (!searchActive) {
            return;
        }
        
        self.filteredMovies = movies.filter{ ($0["original_title"] as? String)?.lowercased().range(of: searchText.lowercased()) != nil }
        self.moviesTableView.reloadData()
    }


    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ moviesTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredMovies.count
        }
        return self.movies.count
    }
    
    func tableView(_ moviesTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        moviesTableView.rowHeight = 130
        let cell: MovieTableViewCell = moviesTableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        //return cell;
        
        var movie:NSDictionary
        
        //If search is active set the filtered movie else the whole list
        if(searchActive){
            movie = self.filteredMovies[indexPath.row]
        } else {
            movie = self.movies[indexPath.row]
        }
        
        cell.movieItem = movie
        
        //Customize the highlight and selection effect of the cell
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 0.09, green: 0.57, blue: 0.78, alpha: 1.0)
        cell.selectedBackgroundView = view
        
        return cell
        
    }
    
    //Remove the gray selection effect:
    /*func tableView(_ moviesTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     moviesTableView.deselectRow(at: indexPath, animated:true)
     }*/
    
    //Prepare data and pass to detail screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "MovieDetailsView") {
            let destinationViewController = segue.destination as! MovieDetailsViewController
           // destinationViewController.passedValue = valueToPass
        
            if let indexPath = moviesTableView.indexPathForSelectedRow {
                let cell: MovieTableViewCell = moviesTableView.cellForRow(at: indexPath) as! MovieTableViewCell
                destinationViewController.image = cell.movieImageView.image
                destinationViewController.movietitle = cell.movieTitleLabel.text!
                destinationViewController.movieoverview = cell.movieOverviewLabel.text!
            
                let movie = self.movies[indexPath.row]
                if let movieRelease = movie.value(forKeyPath: "release_date") as? String {
                    destinationViewController.movierelease = movieRelease
                }
            
                //print(movie.value(forKeyPath: "vote_average") as? Float ??  0)
            
                if let movieVote = movie.value(forKeyPath: "vote_average") as? Float {
                    destinationViewController.movierating = movieVote
                }
                else
                {
                    destinationViewController.movierating = 0
                }
            
            
            }
        }
    }
    
    func loadMovie()
    {
        if let apiCallType = self.controllerType?.rawValue {
            print("controllerTypes", apiCallType)
            
            //API call
            let apikey = "api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
            let url = URL(string:"https://api.themoviedb.org/3/movie/\(apiCallType)?" + apikey)
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
                            //print(self.movies)
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
    }
    
    
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        loadMovie()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row at ", indexPath)
        let movie = self.movies[indexPath.row]
        //var valueToPass: NSDictionary!
        
        //NSDictionary *movie = self.moviesArray[indexPath.row];
        
        //MovieDetailsViewController *mvc = MovieDetailsViewController.init];
        
        //let mvc: MovieDetailsViewController = MovieDetailsViewController.init
       /* let nav1 = UINavigationController()
        let movieDetailController = MovieDetailsViewController()
        let controller = [movieDetailController]
        //tabBarController.viewControllers = [tabViewController1,tabViewController2]
        nav1.viewControllers = controller
        //nav1.viewControllers = controllers
        
        let navigationController = UINavigationController(rootViewController: nav1)*/

     //   let mvc = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
      //  navigationController?.pushViewController(mvc, animated: true);
        
        //valueToPass = movie
        
      //  performSegue(withIdentifier: "MovieDetailsView", sender: self)
      //  let indexPath = moviesTableView.indexPathForSelectedRow
      //  let currentCell = moviesTableView.cellForRow(at: indexPath!) as UITableViewCell!;
      //  let mvc = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
       // let cell: MovieTableViewCell = moviesTableView.cellForRow(at: indexPath!) as! MovieTableViewCell
        //var viewController = mvc.instantiateViewControllerWithIdentifier("MovieDetailsView") as MovieDetailsViewController
        //var viewController = mvc.presentedViewController("MovieDetailsView") as MovieDetailsViewController
        
       // let image = cell.movieImageView.image
      //  let title = cell.movieTitleLabel.text!
      //  let overview = cell.movieOverviewLabel.text!
        //navigationController?.pushViewController(mvc, animated: true);
      //  mvc.passedValue = [image, title, overview]
     //   print(mvc.passedValue)
       // self.presentViewController(viewContoller, animated: true , completion: nil)
     //   navigationController?.pushViewController(mvc, animated: true);
        
        
      //  NSDictionary *movie = self.moviesArray[indexPath.row];
        
        let mvc = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
        //MovieDetailsViewController *mvc = MovieDetailedViewController.init
        mvc.movieDictionary = movie;
        print(mvc.movieDictionary)
        
        //[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
        navigationController?.pushViewController(mvc, animated: true);

        
        //mvc.movieDictionary = movie;
        
    }


}
