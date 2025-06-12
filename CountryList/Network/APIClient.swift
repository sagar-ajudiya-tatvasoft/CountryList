//
//  APIClient.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

class APIClient {
    
    // MARK: - Properties
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    // MARK: - Methods
    static func request<T: Decodable>(endPoint: EndPointType) async throws -> T {
        let request = try endPoint.urlRequest()
        
        do {
            let (data, response) = try await session.data(for: request)

            return try validateRequest(data, response: response, as: T.self)
        } catch let error as URLError {
            switch error.code {
            case .cannotConnectToHost:
                throw NetworkError.serverError
            case .notConnectedToInternet, .networkConnectionLost:
                throw NetworkError.noInternetConnection
            case .timedOut:
                throw NetworkError.timeout
            case .cancelled:
                throw NetworkError.cancelled
            default:
                throw NetworkError.unknownError(error)
            }
        }
    }

    static private func validateRequest<T: Decodable>(_ data: Data, response: URLResponse, as type: T.Type) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        /// Validate status code
        switch httpResponse.statusCode {
        case 200...299:
            break // Successful response
        case 401:
            throw NetworkError.unAuthorized
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        case 500...599:
            throw NetworkError.serverError
        default:
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode, data: data)
        }
        
        /// decode the response
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    // Cancel all running tasks.
    static func cancelAllTasks() {
        session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
}
