//
//  ContentView.swift
//  DogPics
//
//  Created by apple on 16.10.2023.
//

import AVFAudio
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
        case retriever
    }
    
    @StateObject var dogVM = DogViewModel()
    @State private var selectedBreed: Breed = .boxer
 //   @State private var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        VStack {
            titleView
            Spacer()
            
            dogImage
            
            Spacer()
            
            Button("Any Rundom Dog") {
                dogVM.urlString = "https://dog.ceo/api/breeds/image/random"
                Task {
                    await dogVM.getData()
                }
            }
            .bold()
            .buttonStyle(.borderedProminent)
            .foregroundColor(.white)
            .tint(.brown)
            .padding(.bottom)
            
            HStack {
                Button("ShowBread") {
                        dogVM.urlString = "https://dog.ceo/api/breed/\(selectedBreed.rawValue)/images/random"
                    Task {
                        await dogVM.getData()
                    }
                    
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
        .onAppear{
            dogVM.playSound(soundName: "bark")
        }
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
    
    private var dogImage: some View {
        AsyncImage(url: URL(string: dogVM.imageURl)) { phase in
            if let image = phase.image {
                let _ = print("Valid image")
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .shadow(radius: 15)
                    .animation(.default, value: image)
            } else if phase.error != nil {
                let _ = print("Error:Loading Image")
                Image(systemName: "questionmark.square.dashed")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .shadow(radius: 15)
            } else {
                let _ = print("Placeholder image")
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .shadow(radius: 15)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
