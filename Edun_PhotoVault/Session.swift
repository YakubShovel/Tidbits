//
//  Session.swift
//  Edun_PhotoVault
//
//  Created by Jacob Shavel on 7/12/17.
//  Copyright © 2017 Jacob Shavel. All rights reserved.
//

import Foundation


class Session {
    
    var title: String
    var identifier: String
    var text: String
    var startDate: Date
    
    init(title: String, identifier: String, text: String, startDate: Date) {
        self.title = title
        self.identifier = identifier
        self.text = text
        self.startDate = startDate
    }
}
