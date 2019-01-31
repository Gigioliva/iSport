//
//  FacebookApi.swift
//  iSport
//
//  Created by Gianluigi Oliva on 31/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import FacebookCore

struct MyProfileRequest: GraphRequestProtocol {
    struct Response: GraphResponseProtocol {
        var name: String?
        var id: String?
        var gender: String?
        var email: String?
        var profilePictureUrl: String?
        
        init(rawResponse: Any?) {
            // Decode JSON from rawResponse into other properties here.
            guard let response = rawResponse as? Dictionary<String, Any> else {
                return
            }
            
            if let name = response["name"] as? String {
                self.name = name
            }
            
            if let id = response["id"] as? String {
                self.id = id
            }
            
            if let email = response["email"] as? String {
                self.email = email
            }
            
            if let picture = response["picture"] as? Dictionary<String, Any> {
                if let data = picture["data"] as? Dictionary<String, Any> {
                    if let url = data["url"] as? String {
                        self.profilePictureUrl = url
                    }
                }
            }
        }
    }
    
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields":"id, email, name, picture.width(480).height(480)"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
}
