//
//  ContentView.swift
//  PicWorth
//
//  Created by Kun Huang on 4/28/20.
//  Copyright © 2020 Kun Huang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchWord: String = "One"
    
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
                })
            }
            .frame(maxWidth: .infinity)
            Text("\(searchWord) Definition: \n\(getDefinition(term: searchWord))")
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
    
    func getDefinition(term: String) -> String {
        print(term)
        if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: term) {
            print("have dic")
            let ref = UIReferenceLibraryViewController(term: term)
            return ref.description
        }
        return "No Definition"
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
