//
//  ContentView.swift
//  Star Wars Cats
//
//  Created by Brandon Jemison on 12/19/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var catsListVM = CatsListViewModel()

    var body: some View {
        NavigationView {
            List(catsListVM.catSearchResults.sorted(by: { $0.name < $1.name }), id: \.name) { cat in
                HStack {
                    CatListRow(cat: cat).modifier(ImageModifier(width: 84, height: 84))
                    Text(cat.name)
                    NavigationLink(destination: CatDetailedView(catViewModel: cat)
                    ) {
                        Text("")
                    }
                }
            }
            .onAppear {
                catsListVM.getCats()
            }
            .navigationBarTitle("Star Wars Cats")
            .searchable(text: $catsListVM.searchText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ImageModifier: ViewModifier {
    
    @State var width: CGFloat
    @State var height: CGFloat
    
    func body(content: Content) -> some View {
        return content
            .frame(width: width, height: height)
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 10, x:1, y:1 )
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 10, x:1, y:1 )
    }
}
