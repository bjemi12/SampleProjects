//
//  Cat.swift
//  Star Wars Cats
//
//  Created by Brandon Jemison on 12/19/21.
//

import Foundation
import Kumo
import Combine

struct Results: Codable {
    var results: [Cat]
}

struct Cat: Codable, Hashable {
    let name: String
    let height : String?
    let mass : String?
    let hairColor : String?
    let skinColor : String?
    let eyeColor : String?
    let birthYear : String?
    let gender : String?
    let image : String
}

class MyService {
    let service = Service(baseURL: URL(string:"https://duet-public-content.s3.us-east-2.amazonaws.com/"))
    
    func Cats() -> AnyPublisher<Results, Error> {
        self.service.perform(HTTP.Request.get("project.json"))
    }
}



