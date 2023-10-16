//
//  ContentView.swift
//  DogPics
//
//  Created by apple on 16.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    enum Breed: String, CaseIterable {
        case boxer
        case bulldog
        case chihuahua
        case corgi
        case labradoodle
        case poodle
        case pug
        case retriver
    }
    
    @State private var selectedBreed: Breed = .boxer
    
    var body: some View {
        VStack {
           titleView
            
            Spacer()
            
            Button("Any Rundom Dog") {
                //button action
            }
            .bold()
            .buttonStyle(.borderedProminent)
            .foregroundColor(.white)
            .tint(.brown)
            .padding(.bottom)
            
            HStack {
                Button("ShowBread") {
                    //button action
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
                .padding(.bottom)
                
                Picker("", selection: $selectedBreed) {
                    ForEach(Breed.allCases, id: \.self) {breed in
                        Text(breed.rawValue.capitalized)
                    }
                }
            }
            .bold()
            .tint(.brown)
        }
        .padding()
    }
}

extension ContentView {
    private var titleView: some View {
        return Text("🐶 Dog Pics!")
            .font(.custom("Avenir Next Condensed", size: 60))
            .bold()
            .foregroundColor(.brown)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
