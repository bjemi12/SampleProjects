//
//  CatsListViewModel.swift
//  Star Wars Cats
//
//  Created by Brandon Jemison on 12/26/21.
//

import Foundation
import SwiftUI

class CatsListViewModel : ObservableObject{
    @Published var cats: [CatViewModel] = []
    @Published var searchText = ""
     var catSearchResults: [CatViewModel] {
        if searchText.isEmpty {
            return self.cats
        } else {
            return self.cats.filter { $0.name.contains(searchText) }
        }
    }
    
    func getCats() {
       guard let url = URL(string: "https://duet-public-content.s3.us-east-2.amazonaws.com/project.json") else { return }
       
       let urlRequest = URLRequest(url: url)
       
       let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
           if let error = error {
               print("There was an error with the request error: \(error)")
               return
           }
           
           guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
           
           guard let data = data else { return }
           
           let decoder = JSONDecoder()
           
           decoder.keyDecodingStrategy = .convertFromSnakeCase

           DispatchQueue.main.async {
               do {
                   let decodedCats = try decoder.decode(Results.self, from: data)
                   self.cats = decodedCats.results.map { CatViewModel(cat: $0)
                   }
               } catch let error {
                   print("Error decoding data: \(error)")
               }
           }
       }
       dataTask.resume()
   }
}
