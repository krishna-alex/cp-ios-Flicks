//
//  NowPlayingViewController.swift
//  Flicks
//
//  Created by Krishna Alex on 4/2/17.
//  Copyright © 2017 Krishna Alex. All rights reserved.
//

import UIKit

class NowPlayingViewController: MovieListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init() {
        super.init(nibName: "MovieListViewController", bundle: nil)
        self.controllerType = controllerTypes.nowPlaying;        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
