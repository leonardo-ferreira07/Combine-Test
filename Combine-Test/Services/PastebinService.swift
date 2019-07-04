//
//  PastebinService.swift
//  Combine-Test
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 26/06/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
import Combine

class PastebinService {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
}

extension PastebinService {
    func getData() -> AnyPublisher<[PastebinObject], Error> {
        guard let url = URL(string: "https://pastebin.com/raw/wgkJgazE") else {
            fatalError("error on creating URL")
        }
        
        return session.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [PastebinObject].self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

