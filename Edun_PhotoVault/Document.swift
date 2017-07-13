//
//  Document.swift
//  Edun_PhotoVault
//
//  Created by Jacob Shavel on 7/12/17.
//  Copyright © 2017 Jacob Shavel. All rights reserved.
//

import Foundation
import Gloss


class Document: Decodable, Glossy {
    
    var key: String?
    var title: String?
    var identifier: String?
    var text: String?
    var startDate: Date?
    var mostRecentEdit: Date?
    
    init(title: String, identifier: String, text: String, startDate: Date, mostRecentEdit: Date) {
        self.key = ""
        self.title = title
        self.identifier = identifier
        self.text = text
        self.startDate = startDate
        self.mostRecentEdit = startDate
    }
    
    // Initialize swift class from json (dictionary)
    required init?(json: JSON) {
        self.title = json["title"] as? String
        self.identifier = json["identifier"] as? String
        self.text = json["text"] as? String
        
        
        //changing the dates' format from string to Date for swift
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd hh':'mm':'ss"
        
        if let startDateString = json["startDate"] as? String {
            self.startDate = dateFormatter.date(from: startDateString)
        } else {
            self.startDate = nil
        }
        
        if let mostRecentEditString = json["mostRecentEdit"] as? String {
            self.mostRecentEdit = dateFormatter.date(from: mostRecentEditString)
        } else {
            self.mostRecentEdit = nil
        }
        

    }
    
    // Serialize swift class to json (dictionary)
    func toJSON() -> JSON? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd hh':'mm':'ss"
        
        var startDateString: String?
        var mostRecentEditString: String?
        
        if let startDate = self.startDate {
            startDateString = dateFormatter.string(from: startDate)
        }
        
        if let mostRecentEdit = self.mostRecentEdit {
            mostRecentEditString = dateFormatter.string(from: mostRecentEdit)
        }
        
        return jsonify(["title" ~~> self.title,
                        "identifier" ~~> self.identifier,
                        "text" ~~> self.text,
                        "startDate" ~~> startDateString,
                        "mostRecentEdit" ~~> mostRecentEditString])
    }
}
