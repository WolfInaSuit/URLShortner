//
//  ViewModel.swift
//  URLShortner
//
//  Created by Stevie Cassh on 6/6/22.
//

import Foundation

struct Model: Hashable {
    let long: String
    let short: String
}

class ViewModel: ObservableObject {
    @Published var models = [Model]()
    
    func submit(urlString: String) {
        guard URL(string: urlString) != nil else{
            return
        }
        
            //API Call
        guard let apiUrl = URL(string: "https://api.1pt.co/addURL@long="+urlString.lowercased()) else {
            return
        }
        
        print(apiUrl.absoluteString)
        
        let task = URLSession.shared.dataTask(with: apiUrl) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            //Convert data to JSON
            do{
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                print("RESULT: \(result)")
                let long = result.long
                let short = result.short
                DispatchQueue.main.async {
                    self?.models.append(.init(long: long, short: short))
                }
            }
            
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

// Cuttly Url Shorter API
// API Key: 'a31a40ee315d3617b0c1f11ade9dffd6c5627'
// File Link : 'https://cutt.ly/api/api.php'


struct APIResponse: Codable {
    let status: Int
    let message: String
    let short: String
    let long: String
}


