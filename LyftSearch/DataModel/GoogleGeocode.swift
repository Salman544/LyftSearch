//
//  GoogleGeocode.swift
//  LyftSearch
//
//  Created by Muhammad Salman Zafar on 26/12/2018.
//  Copyright © 2018 Muhammad Salman Zafar. All rights reserved.
//

import Foundation

struct GoogleGeocode : Codable {
    let results: [Result]?
    let status: String?    
}

struct Result : Codable {
    let addressComponents: [AddressComponent]?
    let formattedAddress: String?
    let geometry: Geometry?
    let placeID: String?
    let types: [String]?
}

struct AddressComponent : Codable {
    let longName: String?
    let shortName: String?
    let types: [String]?
}

struct Geometry : Codable {
    let location: Location?
    let locationType: String?
    let viewport: Bounds?
    let bounds: Bounds?
}

struct Bounds : Codable {
    let northeast: Location?
    let southwest: Location?
}

struct Location : Codable {
    let lat: Double?
    let lng: Double?
}
