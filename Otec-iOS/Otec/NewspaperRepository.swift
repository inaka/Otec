//
//  NewspaperRepository.swift
//  Otec
//
//  Created by El gera de la gente on 5/24/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import Foundation
import Jayme
class NewspaperRepository: ServerRepository {
    
    typealias EntityType = Newspaper
    let backend = ServerBackend()
    let path = "newspapers"

    private func pathForID(id: Identifier) -> Path {
        return self.path
    }
    
}