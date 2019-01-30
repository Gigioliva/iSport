//
//  TestLoginFacebookViewController.swift
//  iSport
//
//  Created by Gianluigi Oliva on 30/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class LoginFacebookViewController: UIViewController {

    @IBOutlet weak var Logo: UILabel!
    let loginButton = LoginButton(readPermissions: [ .publicProfile ])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginButton)
        loginButton.center = view.center
        
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        if AccessToken.current != nil {
            performSegue(withIdentifier: "Login", sender: nil)
        }
    }
    
}
