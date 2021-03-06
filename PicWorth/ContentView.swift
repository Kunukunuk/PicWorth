//
//  ContentView.swift
//  PicWorth
//
//  Created by Kun Huang on 4/28/20.
//  Copyright © 2020 Kun Huang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchWord: String = "Apple"
    @State private var definitionText: Text = Text("Definitions")
    @State private var definitionList: [String] = []
    private let url = URL(string: "https://pixabay.com/static/img/public/medium_rectangle_b.png")!
    @State private var imageHits: [ImageData]?
    
    var body: some View {
        VStack {
            Text("Enter a word to search")
            HStack (spacing: 20) {
                TextField("Enter a word", text: $searchWord, onCommit: {
                    self.getDefinition(term: self.searchWord)
                })
                    .frame(maxWidth: .infinity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Search", action: {
                    self.getDefinition(term: self.searchWord)
                })
            }
            .frame(maxWidth: .infinity)
            Group {
                Text("Definitions")
                definitionText
            }
            ImageView()
            CollectionView(imageData: $imageHits)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .onAppear {
            self.getDefinition(term: self.searchWord)
        }
    }
    
    func getDefinition(term: String) {
        
        if term.isEmpty {
            self.definitionText = Text("Enter something to search")
            return
        }
        definitionList = []
        APIManager.apiManager.getDefinition(term: term) { result in
            switch result {
                case .success(let definitions):
                    if definitions.isEmpty {
                        self.definitionText = Text("No Definition available")
                        break
                    }
                    for each in definitions {
                        if self.searchWord.lowercased() == each.word {
                            if let listOfDefinitions = each.defs {
                                let getDefs = listOfDefinitions.joined(separator: "\n")
                                let displayDef = getDefs.replacingOccurrences(of: "n\t", with: "\u{2022}")
                                self.definitionText = Text(displayDef)
                                self.getNumberOfImages(term: term)
                                break;
                            }
                        }
                        self.definitionText = Text("No Definition available")
                    }
                case .failure(let error):
                    self.definitionText = Text("Failed to retrieve info from API")
                    print(error)
            }
        }
    }
    
    func getNumberOfImages(term: String) {
        
        imageHits = []
        APIManager.apiManager.getImageHits(term: term) { result in
            switch result {
                case .success(let images):
                    if images.isEmpty {
                        break
                    }
                    self.imageHits = images
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
