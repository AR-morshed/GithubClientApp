//
//  NetworkService.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 9/6/25.
//

import Foundation

struct NetworkService {
  private let baseURL = BuildConfiguration.shared.baseURLString

  func request<T: Decodable>(api: GithubAPI) async throws -> T {

    guard var urlComponents = URLComponents(string: "\(baseURL)/\(api.path)")
    else {
      throw NetworkError.invalidURL
    }
    urlComponents.queryItems = api.queryItems

    guard let url = urlComponents.url else {
      throw NetworkError.invalidURL
    }

    var request = URLRequest(url: url)
    request.httpMethod = api.httpMethod

    if let headers = api.headers {
      for (key, value) in headers {
        request.setValue(value, forHTTPHeaderField: key)
      }
    }

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let response = response as? HTTPURLResponse,
      response.statusCode == 200
    else {
      throw NetworkError.invalidResponse
    }

    do {
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      throw NetworkError.decodingError
    }
  }
}
