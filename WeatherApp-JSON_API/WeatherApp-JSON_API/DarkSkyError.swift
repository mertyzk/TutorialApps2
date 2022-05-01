//
//  DarkSkyError.swift
//  WeatherApp-JSON_API
//
//  Created by Macbook Air on 1.05.2022.
//

import Foundation

enum DarkSkyError {
    case RequestError
    case ResponseUnsuccesful(statusCode : Int)
    case invalidData
    case JSONParsingError
    case invalidURL
}
