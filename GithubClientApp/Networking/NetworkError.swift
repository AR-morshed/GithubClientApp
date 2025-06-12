//
//  NetworkError.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 9/6/25.
//

import Foundation

enum NetworkError: Error {
  case invalidURL
  case invalidResponse
  case dataError
  case decodingError
}
