//
//  PastebinObject.swift
//  Combine-Test
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 26/06/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
import Combine

struct PastebinObject: Codable {
    let id: String
    let likes: Int
    let user: User
    
    struct User: Codable {
        let name: String
        let profileImage: ProfileImage
        
        enum CodingKeys: String, CodingKey {
            case name
            case profileImage = "profile_image"
        }
        
        struct ProfileImage: Codable {
            let small: URL
            let large: URL
        }
        
    }
}
