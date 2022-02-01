//
//  CatDetailedView.swift
//  Star Wars Cats
//
//  Created by Brandon Jemison on 12/19/21.
//

import SDWebImageSwiftUI
import SwiftUI

struct CatDetailedView: View {
    @State var catViewModel: CatViewModel
   
    var body: some View {
        VStack(spacing: 10) {
            CatImage(cat: catViewModel).modifier(ImageModifier(width: 200, height: 200))
            Text(catViewModel.cat.name)
            ScrollView {
                AttributesView(cat: catViewModel)
            }
        
        }
        .toolbar {
            ShareButton(cat: catViewModel)
        }
        
    }
}

struct CatDetailedView_Previews: PreviewProvider {
    @State static var isGrayscaledEnabled: Bool = false
    @State static var cat: CatViewModel = CatViewModel(cat: Cat(name: "", height: "", mass: "", hairColor: "", skinColor: "", eyeColor: "", birthYear: "", gender: "", image: ""))
    static var previews: some View {
        CatDetailedView(catViewModel: cat)
    }
}


struct CatImage: View {
    @State var cat: CatViewModel
    
    var body: some View {
        WebImage(url: URL(string: cat.image))
            .resizable()
            .placeholder {
                ProgressView()
            }
            .scaledToFit()
            .modifier(ImageModifier(width: 284, height: 284))
    }
}


struct ShareButton: View {
    @State var cat: CatViewModel
    
    var body: some View {
        Button(action: shareButton) {
            Image(systemName: "square.and.arrow.up")
        }
    }
    
    func shareButton() {
        
        let url = cat.image
        
        let  imageURL = URL(string: url)
        
        let data = try! Data(contentsOf: imageURL!)
        
        let image = UIImage(data: data )
        
        let activityController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        _ = windowScene?.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}

struct AttributeRow: View {
    @State var attributeTitle: String?
    @State var attributeName: String
    
    var body: some View {
        Divider().background(Color.gray)
        HStack {
            Text(attributeTitle ?? "").padding(.leading)
            Text(attributeName)
            Spacer()
        }
    }
}

struct AttributesView: View {
    @State var cat: CatViewModel
    
    var body: some View {
        Group {
            AttributeRow(attributeTitle: "Birth Year: ", attributeName: cat.birthYear )
            AttributeRow(attributeTitle: "Mass: ", attributeName: cat.mass )
            AttributeRow(attributeTitle: "Height: ", attributeName: cat.height )
            AttributeRow(attributeTitle: "Skin Color: ", attributeName: cat.skinColor )
            AttributeRow(attributeTitle: "Gender: ", attributeName: cat.gender )
            AttributeRow(attributeTitle: "Hair Color: ", attributeName: cat.hairColor )
            AttributeRow(attributeTitle: "Eye Color: ", attributeName: cat.eyeColor )
            Divider().background(Color.gray)
            Spacer(minLength: 30)
        }
        .font(Font.system(.headline))
    }
}
