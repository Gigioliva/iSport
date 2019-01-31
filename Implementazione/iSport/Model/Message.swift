//
//  Message.swift
//  iSport
//
//  Created by Gianluigi Oliva on 31/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import Foundation
import UIKit
import MessageKit

struct Member {
    let name: String
    let image: String
}

struct Message {
    let member: Member
    let text: String
    let messageId: String
}

extension Message: MessageType {
    var sender: Sender {
        return Sender(id: member.name, displayName: member.name)
    }
    
    var sentDate: Date {
        return Date()
    }
    
    var kind: MessageKind {
        return .text(text)
    }
}

extension Member {
    var toJSON: Any {
        return [
            "name": name,
            "image": image
        ]
    }
    
    init?(fromJSON json: Any) {
        guard
            let data = json as? [String: Any],
            let name = data["name"] as? String,
            let image = data["image"] as? String
            else {
                print("Couldn't parse Member")
                return nil
        }
        
        self.name = name
        self.image = image
    }
}
