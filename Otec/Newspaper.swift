//
//  Newspaper.swift
//  Otec
//
// Copyright (c) 2016 Inaka - http://inaka.net/
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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