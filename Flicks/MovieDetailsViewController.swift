//
//  MovieDetailsViewController.swift
//  Flicks
//
//  Created by Krishna Alex on 4/2/17.
//  Copyright © 2017 Krishna Alex. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDetailsScrollView: UIScrollView!
    @IBOutlet weak var movieDetailsTitleLabel: UILabel!
    @IBOutlet weak var movieDetailsOverviewLabel: UILabel!
    @IBOutlet weak var movieDetailsRelease: UILabel!
    @IBOutlet weak var movieDetailsRating: UILabel!
    
    
    var image: UIImage!
    var movietitle: String!
    var movieoverview: String!
    var movierelease: String!
    var movierating: Float!
    var passedValue: NSArray!
    var movieDictionary: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     //   movieImageView.image = movieDictionary.firstObject as! UIImage?
     //   movieDetailsTitleLabel.text = movieDictionary.object(at: 1) as? String
     //   movieDetailsOverviewLabel.text = passedValue.object(at: 2) as? String
        
        movieDetailsTitleLabel.text = movieDictionary.value(forKeyPath: "original_title") as! String?
        movieDetailsOverviewLabel.text = movieDictionary.value(forKeyPath: "overview") as! String?
        
        
        if let movieImage = movieDictionary.value(forKeyPath: "poster_path") as? String {
            let imageUrlString = "https://image.tmdb.org/t/p/w500" + (movieImage as String)
            let smallImageRequest = NSURLRequest(url: NSURL(string: ("https://image.tmdb.org/t/p/w185" + (movieImage as String)))! as URL)
            let largeImageRequest = NSURLRequest(url: NSURL(string: imageUrlString)! as URL)
            
            self.movieImageView.setImageWith(
                //imageRequest as URLRequest,
                smallImageRequest as URLRequest,
                placeholderImage: nil,
                success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                    self.movieImageView.alpha = 0.0
                    self.movieImageView.image = smallImage
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.movieImageView.alpha = 1.0
                    }, completion: { (sucess) -> Void in
                        
                        self.movieImageView.setImageWith(
                            largeImageRequest as URLRequest,
                            placeholderImage: smallImage,
                            success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                                
                                self.movieImageView.image = largeImage;
                                
                        },
                            failure: { (request, response, error) -> Void in
                                // On failure condition of the large image request, setting the ImageView's image to a small resolution image
                                self.movieImageView.image = smallImage
                                
                        })
                        
                    })
                    
            },failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
            })
        }
        let rating = movieDictionary.value(forKeyPath: "vote_average") as? Float
        movieDetailsRating.text = "\(rating!)"
        movieDetailsRating.sizeToFit()
        
        
        let releaseDate = movieDictionary.value(forKeyPath: "release_date") as? String
        
        let Formatter = DateFormatter()
        Formatter.dateStyle = DateFormatter.Style.medium
        Formatter.dateFormat = "yyyy-MM-dd"
        let parsedReleaseDate = Formatter.date(from: releaseDate!)
        
        Formatter.locale = Locale(identifier: "en_US")
        Formatter.dateStyle = DateFormatter.Style.long
        movieDetailsRelease.text = Formatter.string(from: parsedReleaseDate!)
        
        movieDetailsRelease.sizeToFit()
 
        let contentWidth = movieDetailsScrollView.bounds.width
        let contentHeight = movieDetailsScrollView.bounds.height
        movieDetailsScrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
