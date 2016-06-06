//
//  News.swift
//  Otec
//
//  Created by El gera de la gente on 5/19/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import Foundation
import Jayme
import SwiftyJSON

struct News: Identifiable {
    let id: String
    let title : String
    let body : String
    let newspaper : String
    let creationDate : NSDate
}

extension News: DictionaryInitializable, DictionaryRepresentable {
    
    init(dictionary: [String: AnyObject]) throws {
        let json = JSON(dictionary)
        guard let
            id = json["id"].string,
            title = json["title"].string,
            body = json["body"].string,
            newspaper = json["newspaper_name"].string,
            createdAt = News.creationDateFromDateString(json["created_at"].string)
            else {  throw JaymeError.ParsingError }
        self.id = id
        self.title = title
        self.body = body
        self.newspaper = newspaper
        self.creationDate = createdAt
    }
    
    init?(dictionary: [String:String]) {
        guard let
            id = dictionary["id"],
            title = dictionary["title"],
            body = dictionary["body"],
            newspaper = dictionary["newspaper_name"],
            createdAt = News.creationDateFromDateString(dictionary["created_at"])
            else { return nil }
        self.id = id
        self.title = title
        self.body = body
        self.newspaper = newspaper
        self.creationDate = createdAt
    }
    
    private static func creationDateFromDateString(dateString: String?) -> NSDate? {
        guard let creationDateString = dateString else { return nil }
        
        return NSDate()
        
    }
    private func dateStringFromCreationDate(date: NSDate) -> String {
        return "12/19/1989"
    }
    var dictionaryValue: [String: AnyObject] {
        return [
            "id": self.id,
            "title": self.title,
            "body": self.body,
            "newspaper": self.newspaper
        ]
    }
    
}