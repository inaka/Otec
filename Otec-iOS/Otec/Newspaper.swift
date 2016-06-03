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
    let id: String
    let news: [News]
    let description : String
}

extension Newspaper: DictionaryInitializable, DictionaryRepresentable {
    
    init(dictionary: [String: AnyObject]) throws {
        let json = JSON(dictionary)
        guard let
            id = json["name"].string,
            description = json["description"].string
//            news = json["news"].array
            else { throw JaymeError.ParsingError }
        self.id = id
        self.description = description
        self.news = [News]()//Newspaper.newsFromDictionary(["":""])
    }
    
    private static func newsFromDictionary (news: [JSON]) -> [News]{
        
        return [News]()
    }
    
    var dictionaryValue: [String: AnyObject] {
        return [
            "name": self.id,
            "description": self.description
        ]
    }
    
}

extension String: CustomStringConvertible { public var description: String { return self } }