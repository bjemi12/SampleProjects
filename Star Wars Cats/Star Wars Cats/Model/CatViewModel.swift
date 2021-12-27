//
//  CatViewModel.swift
//  Star Wars Cats
//
//  Created by Brandon Jemison on 12/24/21.
//

import Foundation

struct CatViewModel: Codable {
    let cat: Cat

    var name : String {
        cat.name
    }
    
    var height : String {
        cat.height ?? "N/A"
    }
    
    var mass : String {
        cat.mass ?? "N/A"
    }
    
    var hairColor : String {
        cat.hairColor ?? "N/A"
    }
    
    var skinColor  : String {
        cat.skinColor ?? "N/A"
    }
    
    var eyeColor : String {
        cat.eyeColor ?? "N/A"
    }
    
    var birthYear : String {
        cat.birthYear ?? "N/A"
    }
    
    var gender : String {
        cat.gender ?? "N/A"
    }
    
    var image : String {
        cat.image
        
    }
}
