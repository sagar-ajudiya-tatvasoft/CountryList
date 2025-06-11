//
//  NetworkError.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidUrl
    case encodingError
    case invalidResponse
    case unAuthorized
    case notFound
    case forbidden
    case serverError
    case noInternetConnection
    case timeout
    case cancelled
    case unknownError(Error)
    case decodingError(Error)
    case requestFailed(statusCode: Int, data: Data?)
    
    var errorDescription: String {
        switch self {
        case .invalidUrl:
            return "The URL provided was invalid."
        case .encodingError:
            return "Failed to encode the request data."
        case .invalidResponse:
            return "The response from the server was invalid."
        case .unAuthorized:
            return "You are not authorized to perform this action."
        case .notFound:
            return "The requested resource was not found."
        case .forbidden:
            return "Forbidden access."
        case .serverError:
            return "Server encountered an error."
        case .noInternetConnection:
            return "No internet connection."
        case .timeout:
            return "The request timed out."
        case .cancelled:
            return"The request was cancelled."
        case .unknownError(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .requestFailed(let statusCode, let data):
            return "Request failed with status code \(statusCode). Data: \(data?.description ?? "No data")"
        }
    }
}
