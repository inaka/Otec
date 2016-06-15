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
    
    func listenToNewsWithEventSource(eventSource: EventSource, newReceivedCompletion completion: Result <News, JaymeError> -> ()) {
        UserNewspaperSession.newspapersSubscribed().forEach{
            eventSource.addEventListener($0) { (esId, esEvent, esData) in
                guard let id = esId,
                    let event = esEvent,
                    let data =  esData else {
                        completion (Result.Failure(JaymeError.BadResponse))
                        return
                }
                guard let new = try? self.createNewFromSSEEvent(id, event: event, data: data) else {
                    completion (Result.Failure(JaymeError.ParsingError))
                    return
                }
                completion(Result.Success(new))
            }
        }
    }
    
    func newsEventSource() -> EventSource {
        return EventSource(url: self.urlStringWithPath(self.name) , headers: ["Accept":"application/json"])
    }
    
    private func urlStringWithPath(path: String) -> String {
        return Constants.CanillitaBackendLocalHostURL + "/" + path
    }
    
    private func createNewFromSSEEvent(id: String, event: String, data: String) throws -> News {
        let titleAndBodyOfNew = data.componentsSeparatedByString("\n")
        let title = titleAndBodyOfNew[0]
        let body = titleAndBodyOfNew[1]
        
        let newDictionary = ["title":title,
                             "body":body,
                             "id":id,
                             "newspaper_name":event]
        guard let new = try? News(dictionary:newDictionary) else {
            throw JaymeError.ParsingError
        }
        return new
    }
    
    func listenToNewsPaper(newspaperId: String, newReceivedCompletion completion: Result <News, JaymeError> -> ()) {
        self.newsEventSource().addEventListener(newspaperId) { (esId, esEvent, esData) in
            guard let id = esId,
                let event = esEvent,
                let data =  esData else {
                    completion (Result.Failure(JaymeError.BadResponse))
                    return
            }
            guard let new = try? self.createNewFromSSEEvent(id, event: event, data: data) else {
                completion (Result.Failure(JaymeError.ParsingError))
                return
            }
            completion(Result.Success(new))
        }
    }
}
