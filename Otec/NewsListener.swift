//
//  NewsListener.swift
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
import IKEventSource
import Jayme

class NewsListener {
    
    let name = "news"
    
    func listenToNewsWithEventSource(_ eventSource: EventSource, forNewspapersIDs newspapersIDs: [String], newReceivedCompletion completion: @escaping (Result <News, JaymeError>) -> ()) {
        newspapersIDs.forEach {
            eventSource.addEventListener($0) { (esId, esEvent, esData) in
                guard let id = esId,
                    let event = esEvent,
                    let data =  esData else {
                        completion (Result.failure(JaymeError.badResponse))
                        return
                }
                guard let new = try? self.createNewFromSSEEvent(id, event: event, data: data) else {
                    completion (Result.failure(JaymeError.parsingError))
                    return
                }
                completion(Result.success(new))
            }
        }
    }
    
    func newsEventSource() -> EventSource {
        return EventSource(url: self.urlStringWithPath(self.name), headers: ["Accept":"application/json"])
    }
    
    fileprivate func urlStringWithPath(_ path: String) -> String {
        return Constants.CanillitaBackendLocalHostURL + "/" + path
    }
}

extension NewsListener {
    fileprivate func createNewFromSSEEvent(_ id: String, event: String, data: String) throws -> News {
        let titleAndBodyOfNew = data.components(separatedBy: "\n")
        let title = titleAndBodyOfNew[0]
        let body = titleAndBodyOfNew[1]
        
        let newDictionary = ["title":title,
                             "body":body,
                             "id":id,
                             "newspaper_name":event]
        guard let new = try? News(dictionary:newDictionary as [String : AnyObject]) else {
            throw JaymeError.parsingError
        }
        return new
    }
}
