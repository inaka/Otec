//
//  NewsRepository.swift
//  Otec
//
//  Created by El gera de la gente on 5/24/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import Foundation
import Jayme
class NewsRepository: ServerRepository {
    
    typealias EntityType = News
    let backend = ServerBackend()
    let path = "News"
    
}