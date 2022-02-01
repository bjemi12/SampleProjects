//
//  CatsListViewModel.swift
//  Star Wars Cats
//
//  Created by Brandon Jemison on 12/26/21.
//

import Combine
import Foundation
import Kumo
import SwiftUI

class CatsListViewModel : ObservableObject{
    @Published var cats: [CatViewModel] = []
    @Published var searchText = ""
    let service = MyService()
    private var cancellable: AnyCancellable?
    var catSearchResults: [CatViewModel] {
        if searchText.isEmpty {
            return self.cats.sorted(by: { $0.name < $1.name })
        } else {
            return self.cats.filter { $0.name.contains(searchText) }.sorted(by: { $0.name < $1.name })
        }
    }
   
    func getCats() {
//        COMBINE
                guard let url = URL(string: "https://duet-public-content.s3.us-east-2.amazonaws.com/project.json") else { return }

                cancellable = URLSession.shared.dataTaskPublisher(for: url)
                    .tryMap() { element -> Data in
                        guard let httpResponse = element.response as? HTTPURLResponse,
                              httpResponse.statusCode == 200 else {
                                  throw URLError(.badServerResponse)
                              }
                        return element.data
                    }
                    .decode(type: Results.self, decoder: JSONDecoder())
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { print ("Received completion: \($0).") },
                          receiveValue: { user in print ("Received user: \(user).")
                        self.cats = user.results.map { CatViewModel(cat: $0) }
                    })
        
        //KUMO
//        cancellable = service.Cats().sink(receiveCompletion: { print ("Received completion: \($0).") },
//                             receiveValue: { user in
//                           self.cats = user.results.map { CatViewModel(cat: $0) }
//                       })
        }
        
    }
    
