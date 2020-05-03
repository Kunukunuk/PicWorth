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
    @State private var definitionText: Text = Text("Hello")
    @State private var definitionList: [String] = []
    
    var body: some View {
        VStack {
            Text("Enter a word to search")
            HStack (spacing: 20) {
                TextField("Enter a word", text: .constant(searchWord))
                    .onTapGesture {
                        self.searchWord = ""
                    }
                    .frame(maxWidth: .infinity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Search", action: {
                    print(self.searchWord)
                    self.getDefinition(term: self.searchWord)
                })
            }
            .frame(maxWidth: .infinity)
            definitionText
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
    
    func getDefinition(term: String) {
        
        definitionList = []
        APIManager.apiManager.getDefinition(term: term) { result in
            switch result {
                case .success(let definitions):
                    print(definitions)
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
