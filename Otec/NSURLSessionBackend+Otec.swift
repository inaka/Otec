//
//  NSURLSessionBackend+Otec.swift
//  Otec
//
//  Created by El gera de la gente on 6/14/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import Foundation
import Jayme

extension NSURLSessionBackend {
    static func otecBackend() -> NSURLSessionBackend {
        let httpHeaders = [HTTPHeader(field: "Accept", value: "application/json"),
                                                 HTTPHeader(field: "Content-Type", value: "application/json")]
        let configuration = NSURLSessionBackendConfiguration(basePath:Constants.CanillitaBackendURL, httpHeaders:httpHeaders)
        return NSURLSessionBackend(configuration: configuration)
    }
}