//
//  MovieTableViewCell.swift
//  Flicks
//
//  Created by Krishna Alex on 4/2/17.
//  Copyright © 2017 Krishna Alex. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    private var _movie: NSDictionary?
    
    var movieItem: NSDictionary? {
        get {
            return self._movie
        }
        set(movieItem) {
            self._movie = movieItem
            
            if (self._movie != nil) {
                /*self.userName.text = tweet!.user.name
                self.userScreenName.text = tweet!.user.screenName
                self.tweetText.text = tweet!.text
                self.createdAt.text = tweet!.getTimeElapsedSinceCreatedAt()
                
                // Set image.
                NSURLConnection.sendAsynchronousRequest(
                    NSURLRequest(URL: NSURL(string: tweet!.user.profileImageUrl)),
                    queue: NSOperationQueue.mainQueue(),
                    completionHandler: {
                        (response: NSURLResponse!, data: NSData!, err: NSError!) -> Void in
                        let image = UIImage(data: data)
                        self.setImageOnMainThread(self.userProfileImage, image:image)
                }
                )*/
                //Customize the highlight and selection effect of the cell
                let view = UIView()
                view.backgroundColor = UIColor.init(red: 0.09, green: 0.57, blue: 0.78, alpha: 1.0)
                self.selectedBackgroundView = view
            
                
                //If search is active set the filtered movie else the whole list
                if let movie = self._movie {

                    if let movieImage = movie.value(forKeyPath: "poster_path") as? String {
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
                        
                        if let movieLabel = movie.value(forKeyPath: "original_title") as? String {
                            self.movieTitleLabel?.text = movieLabel
                            
                        }
                        if let movieOverview = movie.value(forKeyPath: "overview") as? String {
                            self.movieOverviewLabel?.text = movieOverview
                        }
                    }
                    
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

