//
//  FeatureCard.swift
//  swiftuiDemo
//
//  Created by lee on 2019/10/25.
//  Copyright © 2019 lee. All rights reserved.
//

import SwiftUI

struct FeatureCard: View {
    var species: Species
        
        var body: some View {
            species.image
            .resizable()
            .frame(height: 300)
            .aspectRatio(1, contentMode: .fill)
            .clipped()
            .overlay(TextOverlay(species: species))
        }
}

struct FeatureCard_Previews: PreviewProvider {
//    let species = Species(image: Image("card"), name: "bob", description: "apple")
    static var previews: some View {
        FeatureCard(species: Species(image: Image("card"), name: "bob", description: "apple"))
    }
}

struct TextOverlay: View {
    var species: Species
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle().fill(gradient)
            VStack(alignment: .leading) {
                Text(species.name)
                    .font(.title)
                    .bold()
                Text(species.description)
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct Species {
    var image : Image
    var name : String
    var description : String
    
}
