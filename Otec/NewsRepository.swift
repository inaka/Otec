//
//  NewsRepository.swift
//  Otec
//
//  Created by El gera de la gente on 5/24/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import Foundation
import Jayme
class NewsRepository: CRUDRepository {
    
    typealias EntityType = News
    let backend = NSURLSessionBackend()
    let name = "news"
    
    func create(entity: EntityType) -> Future<EntityType, JaymeError> {
        let path = self.name
        return self.backend.futureForPath(path, method: .POST, parameters: entity.dictionaryValue)
            .andThen { DataParser().dictionaryFromData($0.0) }
            .andThen { EntityParser().entityFromDictionary($0) }
    }
    
}