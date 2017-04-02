//
//  MovieDetailsViewController.swift
//  Flicks
//
//  Created by Krishna Alex on 3/30/17.
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

    override func viewDidLoad() {
        super.viewDidLoad()

        movieImageView.image = image
        movieDetailsTitleLabel.text = movietitle
        movieDetailsOverviewLabel.text = movieoverview
        
        movieDetailsRating.text = "\(movierating!)"
        movieDetailsRating.sizeToFit()

        
        let Formatter = DateFormatter()
        Formatter.dateStyle = DateFormatter.Style.medium
        Formatter.dateFormat = "yyyy-MM-dd"
        let releasedate = Formatter.date(from: movierelease)
        
        Formatter.locale = Locale(identifier: "en_US")
        Formatter.dateStyle = DateFormatter.Style.long
        movieDetailsRelease.text = Formatter.string(from: releasedate!)
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
