//
//  MenuViewController.swift
//  iSport
//
//  Created by Gianluigi Oliva on 30/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import SideMenuSwift
import FacebookLogin
import FacebookCore

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableViewMenu: UITableView!
    
    @IBOutlet weak var ViewLogged: UIView!
    @IBOutlet weak var ImageProfile: CustomImageView!
    @IBOutlet weak var User: UILabel!
    
    
    var listView = ["News", "Live", "Bet", "Chat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMenu.delegate = self
        tableViewMenu.dataSource = self
        tableViewMenu.rowHeight = 50
        
        SideMenuController.preferences.basic.defaultCacheKey = "News"
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "ViewLive")
        }, with: "Live")
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "ViewBet")
        }, with: "Bet")
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "ViewChat")
        }, with: "Chat")
        
    
        
        ImageProfile.layer.borderWidth = 1
        ImageProfile.layer.masksToBounds = false
        ImageProfile.layer.borderColor = UIColor.black.cgColor
        ImageProfile.layer.cornerRadius = ImageProfile.frame.size.width/2
        ImageProfile.clipsToBounds = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if AccessToken.current != nil {
//            let connection = GraphRequestConnection()
//            connection.add(MyProfileRequest()) { response, result in
//                switch result {
//                case .success(let response):
//                    if let url = response.profilePictureUrl, let name = response.name{
//                        self.ViewLogged.isHidden = false
//                        self.ImageProfile.loadImageUsingUrlString(urlString: url)
//                        self.User.text = name
//                    }
//                case .failed(let error):
//                    print("Custom Graph Request Failed: \(error)")
//                }
//            }
//            connection.start()
//
//        }else {
//            ViewLogged.isHidden = true
//        }
//        tableViewMenu.reloadData()
        reloadTable()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listView.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < listView.count {
            let cella = tableViewMenu.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuTableViewCell
            cella.labelMenu.text = listView[indexPath.row]
            cella.imageMenu.image = UIImage(named: listView[indexPath.row].lowercased())
            cella.selectionStyle = .none
            return cella
        }
        else {
            let cella = tableViewMenu.dequeueReusableCell(withIdentifier: "LoginButton", for: indexPath) as! LoginTableViewCell
            let testo = AccessToken.current != nil ? "Logout" : "Login"
            let image = AccessToken.current != nil ? UIImage(named: "logout") : UIImage(named: "login")
            cella.labelLog.text = testo
            cella.imageLog.image = image
            cella.selectionStyle = .none
            return cella
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cella = tableViewMenu.cellForRow(at: indexPath) as? MenuTableViewCell, let testo = cella.labelMenu.text{
            sideMenuController?.setContentViewController(with: testo)
            sideMenuController?.hideMenu()
        }
        if (tableViewMenu.cellForRow(at: indexPath) as? LoginTableViewCell) != nil {
            loginButtonClicked()
        }
    }
    
    func loginButtonClicked() {
        let loginManager = LoginManager()
        
        if AccessToken.current == nil{
            loginManager.logIn(readPermissions: [ .publicProfile ], viewController: self) { loginResult in
                switch loginResult {
                case .failed(let error):
                    print(error)
                case .cancelled:
                    print("User cancelled login.")
                case .success( _, _, _):
                    print("Logged in!")
                    self.reloadTable()
                }
            }
        }
        else{
            loginManager.logOut()
            reloadTable()
        }
    }
    
    func reloadTable(){
        if AccessToken.current == nil{
            listView = ["News", "Live", "Bet"]
            ViewLogged.isHidden = true
        }
        else{
            listView = ["News", "Live", "Bet", "Chat"]
            let connection = GraphRequestConnection()
            connection.add(MyProfileRequest()) { response, result in
                switch result {
                case .success(let response):
                    if let url = response.profilePictureUrl, let name = response.name{
                        self.ViewLogged.isHidden = false
                        self.ImageProfile.loadImageUsingUrlString(urlString: url)
                        self.User.text = name
                    }
                case .failed(let error):
                    print("Custom Graph Request Failed: \(error)")
                }
            }
            connection.start()
        }
        self.tableViewMenu.reloadData()
    }
    

}
