//
//  ViewController.swift
//  Realife
//
//  Created by Kevin Empociello on 22/10/2016.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var viewStar: UIView!
    var screenSize = UIScreen.main.bounds
    var star: StarReview!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        star = StarReview(frame: CGRect(x: 40, y: 0, width: screenSize.width - 80, height: 80))
        star.starMarginScale = 0.3
        star.allowEdit = true
        star.allowAccruteStars = false
        star.minimunValue = -1
        star.starFillColor = UIColor.orange
        star.starBackgroundColor = UIColor.white
        star.addTarget(self, action: "test", for: UIControlEvents.valueChanged)
        viewStar.addSubview(star)
        
        profilePicture.layer.cornerRadius = 50
        profilePicture.layer.borderWidth = 2
        profilePicture.layer.borderColor = UIColor.white.cgColor
    }
    
    func test() {
        print(star.value)
    }
}

