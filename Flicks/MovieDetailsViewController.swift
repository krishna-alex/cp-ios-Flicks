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

        // Do any additional setup after loading the view.
        movieImageView.image = image
        movieDetailsTitleLabel.text = movietitle
        movieDetailsOverviewLabel.text = movieoverview
        
        print(movierating ?? 0)
        movieDetailsRating.text = "\(movierating!)"

        
        let Formatter = DateFormatter()
        Formatter.dateStyle = DateFormatter.Style.medium
        Formatter.dateFormat = "yyyy-MM-dd"
        let releasedate = Formatter.date(from: movierelease)
        
        Formatter.locale = Locale(identifier: "en_US")
        Formatter.dateStyle = DateFormatter.Style.long
        movieDetailsRelease.text = Formatter.string(from: releasedate!)
        
        let contentWidth = movieDetailsScrollView.bounds.width
        let contentHeight = movieDetailsScrollView.bounds.height
        //movieDetailsScrollView.contentSize = CGSizeMake(contentWidth, contentHeight)
        movieDetailsScrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
       /* let subviewHeight = CGFloat(120)
        var currentViewOffset = CGFloat(0);
        
        while currentViewOffset < contentHeight {
         //   let frame = CGRectMake(0, currentViewOffset, contentWidth, subviewHeight).rectByInsetting(dx: 5, dy: 5)
            let frame = CGRect(x: 0, y: currentViewOffset, width: contentWidth, height: subviewHeight).insetBy(dx: 5, dy: 5)
            let hue = currentViewOffset/contentHeight
            let subview = UIView(frame: frame)
            subview.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
            movieDetailsScrollView.addSubview(subview)
            
            currentViewOffset += subviewHeight
        }*/
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
