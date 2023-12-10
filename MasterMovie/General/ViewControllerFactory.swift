//
//  ViewControllerFactory.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation

// Protocol defining the requirements for a view controller factory
protocol ViewControllerFactoryProtocol {
    init(apiClient: APIClientProtocol)
}

// Implementation of the view controller factory
class ViewControllerFactory: ViewControllerFactoryProtocol {
    private let apiClient: APIClientProtocol
    required init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
}

