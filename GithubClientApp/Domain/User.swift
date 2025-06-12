//
//  User.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 9/6/25.
//

import Foundation

struct User: Codable, Sendable, Identifiable, Hashable {
  let login: String
  let id: Int
  let avatarUrl: String?
  let name: String?
  let followers: Int?
  let following: Int?

  public enum CodingKeys: String, CodingKey {
    case login
    case id
    case avatarUrl = "avatar_url"
    case name
    case followers
    case following
  }
}

extension User {
  static let mockOne: User = .init(
    login: "octocat",
    id: 1,
    avatarUrl: "https://github.com/images/error/octocat_happy.gif",
    name: "monalisa octocat",
    followers: 20,
    following: 0
  )

  static let mockTwo: User = .init(
    login: "mojombo",
    id: 2,
    avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4",
    name: "Mojombo (mojombo)",
    followers: 12,
    following: 2
  )
}
