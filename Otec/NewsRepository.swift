//
//  NewsRepository.swift
//  Otec
//
//  Created by El gera de la gente on 5/24/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import Foundation
import Jayme
import IKEventSource
class NewsRepository: CRUDRepository {
    
    typealias EntityType = News
    let backend = NSURLSessionBackend()
    let name = "news"
    
    func findNews(withEventSource eventSource: EventSource, newReceivedCompletion completion: News? -> ()) {
        UserNewspaperSession.newspapersSuscribed().forEach{
            eventSource.addEventListener($0) { (id, event, data) in
                guard let new = try? NewsRepository().createNewFromSSEEvent(id!, event: event!, data: data!) else {
                    completion (nil)
                    return
                }
                completion(new)
            }
        }
    }
    
    func newsEventSource() -> EventSource {
        return EventSource(url: self.urlStringWithPath(self.name) , headers: ["Accept":"application/json"])
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
            return nil
        }
        return new
    }
    
    func create(entity: EntityType) -> Future<EntityType, JaymeError> {
        let path = "newspapers"
        return self.backend.futureForPath(urlStringToCreateNewWithPath(path), method: .POST, parameters: entity.dictionaryValue)
            .andThen { DataParser().dictionaryFromData($0.0) }
            .andThen { EntityParser().entityFromDictionary($0) }
    }
    
    private func urlStringToCreateNewWithPath(path: String) -> String {
        let userNewspaper = UserNewspaperSession.userNewspaperName()
        
        return path + "/" + userNewspaper + "/news"
    }
    
    private func urlStringWithPath(path: String) -> String {
        return "http://localhost:4892" + "/" + path
//        return "http://43e9c7c6.ngrok.io" + "/" + path
    }
    
}