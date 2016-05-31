//
//  Newspaper.swift
//  Otec
//
//  Created by El gera de la gente on 5/19/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import Foundation
import Jayme
import SwiftyJSON

struct Newspaper: Identifiable {
    let id: Identifier
    let news: [News]
    let description : String
}

extension Newspaper: DictionaryInitializable, DictionaryRepresentable {
    
    init?(dictionary: StringDictionary) {
        let json = JSON(dictionary)
        guard let
            id = json["name"].string,
            description = json["description"].string
//            news = json["news"].array
            else { return nil }
        self.id = id
        self.description = description
        self.news = [News]()//Newspaper.newsFromDictionary(["":""])
    }
    
    init(nonJSONdictionary: [String:String]) {
        guard let
            id = nonJSONdictionary["name"],
            description = nonJSONdictionary["description"]
            else {
                self.id = "FAKE"
                self.description = "FAKE"
                self.news = [News]()
                return
        }
        self.id = id
        self.description = description
        self.news = [News]()
    }
    
    private static func newsFromDictionary (news: [JSON]) -> [News]{
        
        return [News]()
    }
    var dictionaryValue: StringDictionary {
        return [
            "name": self.id,
            "description": self.description
        ]
    }
    
}
