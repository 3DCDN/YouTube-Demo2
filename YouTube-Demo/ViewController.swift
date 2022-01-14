//
//  ViewController.swift
//  YouTube-Demo
//
//  Created by Richard St. Onge on 2022-01-12.
//

import UIKit

class ViewController: UIViewController {

    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        model.getVideos()
        
    }


}

