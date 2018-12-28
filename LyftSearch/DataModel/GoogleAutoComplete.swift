//
//  GoogleAutoComplete.swift
//  LyftSearch
//
//  Created by Muhammad Salman Zafar on 26/12/2018.
//  Copyright © 2018 Muhammad Salman Zafar. All rights reserved.
//

import Foundation

struct GoogleAutoComplete: Decodable {
    let predictions: [Prediction]?
    let status: String?
}

struct Prediction: Decodable {
    let description: String?
    let id: String?
    let matchedSubstrings: [MatchedSubstring]?
    let placeId: String?
    let reference: String?
    let structuredFormatting: StructuredFormatting?
    let terms: [Term]?
    let types: [String]?
    let latlng: String?
    
}

struct MatchedSubstring: Decodable {
    let length: Int?
    let offset: Int?
}

struct StructuredFormatting: Decodable {
    let mainText: String?
    let mainTextMatchedSubstrings: [MatchedSubstring]?
    let secondaryText: String?
}

struct Term: Decodable {
    let offset: Int?
    let value: String?
}



// parse the place id

struct ParsePlaceId : Decodable {
    let result: Result!
}
