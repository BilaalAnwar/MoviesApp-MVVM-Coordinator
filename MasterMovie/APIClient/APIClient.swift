//
//  APIClient.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation

// Structure representing the response from the API
struct APIResponse<T: Decodable> {
    let httpStatusCode: Int
    let result: T
}

// Protocol defining the requirements for a URLSession
protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

// Protocol defining the requirements for an API client
protocol APIClientProtocol {
    init(urlSession: URLSessionProtocol)
    func sendRequest<T: Decodable>(_ router: APIRouter) async throws -> APIResponse<T>
}

// Conforming URLSession to URLSessionProtocol
extension URLSession: URLSessionProtocol {
}

// Implementation of the API client
struct APIClient: APIClientProtocol {
    let urlSession: URLSessionProtocol
    
    // Initializer for the API client
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    // Function to send a request and receive a response
    func sendRequest<T: Decodable>(_ router: APIRouter) async throws -> APIResponse<T> {
        var dataResponse: (Data, URLResponse)!
        
        do {
            // Attempt to create a URLRequest from the provided APIRouter
            guard let request = self.makeURLRequest(router: router) else {
                throw APIError.other("Bad request")
            }
            // Fetch data asynchronously using the provided URLSession
            dataResponse = try await urlSession.data(for: request)
        } catch {
            print(error)
            throw APIError.unexpectedError
        }
        
        do {
            // Extract HTTPURLResponse and data from the received response
            let urlResponse = dataResponse?.1 as! HTTPURLResponse
            print(urlResponse.statusCode)
            var data = dataResponse.0
            print(String(decoding: data, as: UTF8.self))
            
            // Handle different HTTP status codes
            switch urlResponse.statusCode {
            case 200...210:
                // Parse the JSON data using the provided Decodable type
                let result = try JSONDecoder().decode(T.self, from: data)
                return APIResponse(httpStatusCode: urlResponse.statusCode, result: result)
            case 401:
                throw APIError.unauthorized
            case 404:
                throw APIError.notFound
            case 500:
                throw APIError.internlServerError
            default:
                throw APIError.other("Something went wrong")
            }
        } catch {
            throw APIError.jsonParsing
        }
    }
}

//MARK: - Private Functions
extension APIClient {
    /// Generate URLRequest object from path, method, and parameters
    private func makeURLRequest(router: APIRouter) -> URLRequest? {
        guard var urlComponent = URLComponents(string: router.baseURL) else {
            return nil
        }
        // Append the endpoint path to the base URL
        urlComponent.path.append("\(router.path)")
        let parameters = router.parameters
        
        var urlRequest: URLRequest?
        switch router.method {
        case .get:
            // Handle GET request with query parameters
            var queryItems: [URLQueryItem] = []
            for (key, value) in parameters {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
            urlComponent.queryItems = queryItems
            guard let url = urlComponent.url else {
                return nil
            }
            urlRequest = URLRequest(url: url)
            
        case .post:
            // Handle POST request with a JSON body
            guard let url = urlComponent.url else {
                return nil
            }
            urlRequest = URLRequest(url: url)
            let body = try? JSONSerialization.data(withJSONObject: router.body)
            let bodyString = String(data: body!, encoding: .utf8)
            print(bodyString!)
            urlRequest?.httpBody = body
        }
        print(urlRequest?.url ?? "")
        // Set the HTTP method
        urlRequest?.httpMethod = router.method.rawValue
        
        // Set request headers
        for (key, value) in router.headers {
            urlRequest?.setValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }
}
