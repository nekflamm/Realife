//
//  Settings.swift
//  Realife
//
//  Created by Nyrandone Noboud-Inpeng on 25/10/2016.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import UIKit

class Settings: UIViewController {

    // MARK: Properties
    @IBOutlet weak var profilePicture: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        profilePicture.layer.cornerRadius = 50
        profilePicture.layer.borderWidth = 2
        profilePicture.layer.borderColor = UIColor.white.cgColor
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
