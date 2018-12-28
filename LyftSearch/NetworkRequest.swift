//
//  NetworkRequest.swift
//  LyftSearch
//
//  Created by Muhammad Salman Zafar on 26/12/2018.
//  Copyright © 2018 Muhammad Salman Zafar. All rights reserved.
//

import Foundation

class NetworkRequest {
    
    static func fetchJson<T: Decodable>(with url: URL, completion: @escaping (T) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("error \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { print("No Data found") ; return }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                completion(try jsonDecoder.decode(T.self, from: data))
            }catch let error {
                print("error in while decoding json => \(error.localizedDescription)")
            }
            
        }.resume()
        
    }
    
}
