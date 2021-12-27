//
//  CatListRow.swift
//  Star Wars Cats
//
//  Created by Brandon Jemison on 12/19/21.
//
import SDWebImageSwiftUI
import SwiftUI

struct CatListRow: View {
    
    @State  var cat: CatViewModel
 
    
    var body: some View {
        WebImage(url: URL(string: cat.image))
            .resizable()
            .placeholder {
                ProgressView()
            }
            .scaledToFit()
            .modifier(ImageModifier(width: 70, height: 70))
    }
}

struct CatListRow_Previews: PreviewProvider {
    @State static var bool: Bool = false
    @State static var cat: CatViewModel = CatViewModel(cat: Cat(name: "", height: "", mass: "", hairColor: "", skinColor: "", eyeColor: "", birthYear: "", gender: "", image: ""))
    static var previews: some View {
        CatListRow(cat: cat)
    }
}
