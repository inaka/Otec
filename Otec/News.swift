//
//  News.swift
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

struct News: Identifiable {
    let id: String
    let title: String
    let body: String
    let newspaper: String
}

extension News: DictionaryInitializable, DictionaryRepresentable {
    
    init(dictionary: [String: Any]) throws {
        guard let
            id = dictionary["id"] as? String,
            let title = dictionary["title"] as? String,
            let body = dictionary["body"] as? String,
            let newspaper = dictionary["newspaper_name"] as? String
            else {  throw JaymeError.parsingError }
        self.id = id
        self.title = title
        self.body = body
        self.newspaper = newspaper
    }

    var dictionaryValue: [String: Any] {
        return [
            "id": self.id as AnyObject,
            "title": self.title as AnyObject,
            "body": self.body as AnyObject,
            "newspaper": self.newspaper as AnyObject
        ]
    }
    
}
