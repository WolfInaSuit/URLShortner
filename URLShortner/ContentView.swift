//
//  ContentView.swift
//  URLShortner
//
//  Created by Stevie Cassh on 6/5/22.
//

import SwiftUI

struct ContentView: View {
    @State var text = ""
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        // Scrollable list of shortend urls
        NavigationView {
            ScrollView(.vertical) {
                //Header: field, button
                header()
            }
            .navigationTitle("SHORT URLS")
        }
    }
    
    @ViewBuilder
    func header() -> some View {
        VStack {
            Text("Enter URL to be shortened")
                .bold()
                .font(.system(size:30))
                .foregroundColor(Color.white)
                .padding()
            
            TextField("URL ...",text: $text)
                .padding()
                .autocapitalization(.none)
                .background(Color.white)
                .cornerRadius(8)
                .padding()
            
            Button(action: {
                // Make api call
                guard !text.isEmpty else{
                    return
                }
                
                viewModel.submit(urlString: text)
                
                text = ""
            }, label: {
                Text("SUBMIT")
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(width: 240, height: 50)
                    .background(Color.pink)
                    .cornerRadius(9)
                    .padding()
                
            })
        }
                .frame(width: UIScreen.main.bounds.width,
                       height:UIScreen.main.bounds.width)
                .background(Color.blue)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
