//
//  GithubAPI.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 9/6/25.
//

import Foundation

enum GithubAPI {
  case loginUser
  case listOfUsers(perPage: Int, since: Int)
  case userDetails(String)
  case fetchUserRepos(username: String, perPage: Int, page: Int)

  var httpMethod: String {
    "GET"
  }

  var path: String {
    switch self {
    case .loginUser:
      "user"

    case .listOfUsers:
      "users"

    case let .userDetails(username):
      "users/\(username)"

    case let .fetchUserRepos(username, _, _):
      "users/\(username)/repos"
    }
  }

  var queryItems: [URLQueryItem]? {
    switch self {
    case let .listOfUsers(perPage, since):
      return [
        URLQueryItem(name: "per_page", value: "\(perPage)"),
        URLQueryItem(name: "since", value: "\(since)"),
      ]

    case let .fetchUserRepos(_, perPage, page):
      return [
        URLQueryItem(name: "per_page", value: "\(perPage)"),
        URLQueryItem(name: "page", value: "\(page)"),
      ]

    case .loginUser, .userDetails:
      return nil
    }
  }

  var headers: [String: String]? {
    var headers: [String: String] = [:]
    headers["Authorization"] = "Bearer " + BuildConfiguration.shared.githubToken
    headers["Accept"] = "application/vnd.github+json"

    return headers
  }
}
