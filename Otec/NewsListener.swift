//
//  NewsListener.swift
//  Otec
//
//  Created by El gera de la gente on 6/15/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import Foundation
import IKEventSource
import Jayme

class NewsListener {
    
    let name = "news"
    
    func listenToNewsWithEventSource(eventSource: EventSource, newReceivedCompletion completion: Result <News, JaymeError> -> ()) {
        UserNewspaperSession.newspapersSubscribed().forEach{
            eventSource.addEventListener($0) { (id, event, data) in
                guard let new = try? self.createNewFromSSEEvent(id!, event: event!, data: data!) else {
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
        return Constants.CanillitaBackendURL + "/" + path
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
}
