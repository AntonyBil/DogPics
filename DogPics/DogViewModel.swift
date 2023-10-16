//
//  DogViewModel.swift
//  DogPics
//
//  Created by apple on 16.10.2023.
//

import Foundation

@MainActor




class DogViewModel: ObservableObject {
    
    private struct Result: Codable {
        let message: String
    }
    
   @Published var imageURl = ""
    var urlString = "https://dog.ceo/api/breeds/image/random"
    
    func getData() async {
        print("🕸Accessing to the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("🚫 Error: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let result = try? JSONDecoder().decode(Result.self, from: data) else {
                print("🚫 JSON Error: Could not decode returned JSON data")
                return
            }
            self.imageURl = result.message
            print("The imageURL is: \(imageURl)")
        } catch {
            print("ERROR: Could not user URL at \(urlString) to get data and response")
        }
    }
    
    
}
