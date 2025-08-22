//
//  API_Call.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 14/07/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct EmptyResponse: Decodable {}

struct APIService {
    static func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        urlParams: [String: Any]? = nil,
        parameters: [String: Any]? = nil,
        headers: [String: Any]? = nil,
        timeout: TimeInterval = 30
    ) async throws -> T {
        
        guard var components = URLComponents(string: url) else {
            throw NetworkError.invalidURL
        }
        
        if let urlParams = urlParams {
            components.queryItems = urlParams.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let finalURL = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeout
        
        if let parameters = parameters, method != .get {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                throw NetworkError.encodingFailed
            }
        }
        
        var finalHeaders = headers ?? [:]
        
        if !APIConstants.accessToken.isEmpty {
            //            print("the access token from api call is : \(APIConstants.accessToken)")
            finalHeaders["Authorization"] = "Bearer \(APIConstants.accessToken)"
        }
        
        
        finalHeaders["Content-Type"] = "application/json"
        for (key, value) in finalHeaders {
            request.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        print("the final URL is", request)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard response is HTTPURLResponse else {
                throw NetworkError.noData
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
            
            if data.isEmpty {
                if T.self == EmptyResponse.self {
                    return EmptyResponse() as! T
                } else {
                    throw NetworkError.noData
                }
            }
            
            guard !data.isEmpty else {
                throw NetworkError.noData
            }
            
            if let rawJSON = String(data: data, encoding: .utf8) {
                print("🟡 Raw JSON Response: \(rawJSON)")
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch let decodingError as DecodingError {
                switch decodingError {
                case .keyNotFound(let key, let context):
                    print("❌ Key '\(key.stringValue)' not found:", context.debugDescription)
                    print("CodingPath:", context.codingPath)
                    
                case .valueNotFound(let type, let context):
                    print("❌ Value of type '\(type)' not found:", context.debugDescription)
                    print("CodingPath:", context.codingPath)
                    
                case .typeMismatch(let type, let context):
                    print("❌ Type mismatch for type '\(type)':", context.debugDescription)
                    print("CodingPath:", context.codingPath)
                    
                case .dataCorrupted(let context):
                    print("❌ Data corrupted:", context.debugDescription)
                    print("CodingPath:", context.codingPath)
                    
                @unknown default:
                    print("❌ Unknown decoding error")
                }
                
                throw NetworkError.decodingFailed
            } catch {
                print("❌ Unexpected error while decoding: \(error.localizedDescription)")
                throw NetworkError.decodingFailed
            }

            
        } catch let error as URLError {
            if error.code == .timedOut {
                throw NetworkError.timeout
            }
            throw error // other URLError
        } catch {
            throw error
        }
    }
    
    
    
}


struct APICaller {
    
    static let shared = APICaller()
    private init() {}
    
    func postRequest<T: Decodable>(
        urlString: String,
        body: [String: Any],
        token: String
    ) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(token)", forHTTPHeaderField: "Authorization")
        
        // Convert dictionary to JSON
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        
        // Await API Call
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        // Check for HTTP errors
        guard 200..<300 ~= httpResponse.statusCode else {
            // Try to decode error JSON
            if let errorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                throw APIError.serverError(statusCode: httpResponse.statusCode, message: errorResponse.message)
            } else {
                let rawMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
                throw APIError.serverError(statusCode: httpResponse.statusCode, message: rawMessage)
            }
        }
        
        // Decode success response
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch let decodingError as DecodingError {
            throw APIError.decodingError(decodingError.detailedDescription)
        } catch {
            throw APIError.decodingError(error.localizedDescription)
        }
    }
}

// MARK: - Error Models
struct APIErrorResponse: Decodable {
    let message: String
}

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int, message: String)
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .serverError(let code, let message):
            return "Server error (\(code)): \(message)"
        case .decodingError(let msg):
            return "Decoding failed: \(msg)"
        }
    }
}


extension DecodingError {
    var detailedDescription: String {
        switch self {
        case .typeMismatch(let type, let context):
            return "Type mismatch for \(type). Context: \(context.debugDescription), CodingPath: \(context.codingPath)"
        case .valueNotFound(let type, let context):
            return "Value not found for \(type). Context: \(context.debugDescription), CodingPath: \(context.codingPath)"
        case .keyNotFound(let key, let context):
            return "Missing key: \(key.stringValue). Context: \(context.debugDescription), CodingPath: \(context.codingPath)"
        case .dataCorrupted(let context):
            return "Data corrupted. Context: \(context.debugDescription), CodingPath: \(context.codingPath)"
        @unknown default:
            return "Unknown decoding error"
        }
    }
}
