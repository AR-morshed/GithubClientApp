//
//  Repo.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 11/6/25.
//

struct Repo: Codable, Sendable, Identifiable {
  let id: Int
  let name: String?
  let fullName: String?
  let owner: User?
  let fork: Bool?
  let url: String?
  let stargazersCount: Int?
  let language: String?
  let description: String?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case fullName = "full_name"
    case owner
    case fork
    case url = "html_url"
    case stargazersCount = "stargazers_count"
    case language
    case description
  }
}

extension Repo {
  static let mockOne = Repo(
    id: 1,
    name: "Hello-World",
    fullName: "octocat/Hello-World",
    owner: nil,
    fork: true,
    url: "https://api.github.com/repos/octocat/Hello-World",
    stargazersCount: 80,
    language: "Swift",
    description: nil
  )

  static let mockTwo = Repo(
    id: 2,
    name: "GoodBye-World",
    fullName: "octocat/GoodBye-World",
    owner: nil,
    fork: false,
    url: "https://api.github.com/repos/octocat/Hello-World",
    stargazersCount: 32,
    language: "Jave",
    description: nil
  )
}
