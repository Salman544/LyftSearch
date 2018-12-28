//
//  ApiRequest.swift
//  LyftSearch
//
//  Created by Muhammad Salman Zafar on 26/12/2018.
//  Copyright © 2018 Muhammad Salman Zafar. All rights reserved.
//

import Foundation

class ApiRequest {
    static let googleMapBaseUrl = "https://maps.googleapis.com/maps/api/"
    static let geocode = "geocode/json"
    static let autocomplete = "place/autocomplete/json"
    static let placedetail = "place/details/json"
    #error("Need Google Map Api Key")
    static let googleMapApiKey = ""
    
    
    static func getUrl(path: String, paramaters: [String: String] = [String:String]()) -> URL? {
        
        var component = URLComponents(string: googleMapBaseUrl + path)
        component?.queryItems = paramaters.map({URLQueryItem(name: $0, value: $1)})
        
        return component?.url
    }
    
}
