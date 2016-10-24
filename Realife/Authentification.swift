//
//  Authentification.swift
//  Realife
//
//  Created by Nyrandone Noboud-Inpeng on 24/10/2016.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase

class Authentification: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var loginFB: FBSDKLoginButton!
    var ref = FIRDatabase.database().reference().child("/users")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loginFB.delegate = self;
        if (FBSDKAccessToken.current() != nil) {
            print("ALREADY SIGNED IN");
            // Go to main page
        }
        loginFB.readPermissions = ["public_profile", "email"];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            var name = user?.displayName
            let email = user?.email
            let photoUrl = user?.photoURL

            if (name != nil && email != nil && photoUrl != nil) {

                var lastSpacePosition = name!.characters.count - 1;
                var lastName = ""
                var firstName = ""
    
                while (lastSpacePosition > 0) {
                    if (name![name!.index(name!.startIndex, offsetBy: lastSpacePosition)] == " ") {
                        break;
                    }
                    lastSpacePosition -= 1;
                }
                
                if (lastSpacePosition == 0) {
                    lastName = ""
                    firstName = name!
                } else {
                    lastName = name!.substring(from: name!.index(name!.startIndex, offsetBy: lastSpacePosition + 1))
                    firstName = name!.substring(to: name!.index(name!.startIndex, offsetBy : lastSpacePosition))
                }

                self.ref.queryOrdered(byChild: "email").queryEqual(toValue: email)
                    .observe(.value, with: { snapshot in
                        
                        if (snapshot.value is NSNull) {
                            let newUser = ["email": email!, "lastName": lastName, "firstName": firstName, "mark": 5, "photoUrl": photoUrl!.absoluteString, "localisation": "N.C."] as [String : Any]
                            let firebaseNewUser = self.ref.childByAutoId()
                            firebaseNewUser.setValue(newUser)
                        } else {
                            let new_vc = self.storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! ViewController
                            self.navigationController?.pushViewController(new_vc, animated: true)
                        }
                })
            
            }
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        try! FIRAuth.auth()!.signOut()
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
