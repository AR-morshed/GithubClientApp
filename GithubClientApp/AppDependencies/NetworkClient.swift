//
//  NetworkClient.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 10/6/25.
//

import ComposableArchitecture

@DependencyClient
struct NetworkClient {
  var fetchLoginUser: @Sendable () async throws -> User
  var fetchUsers: @Sendable (Int, Int) async throws -> [User]
  var fetchRepoList: @Sendable (String, Int, Int) async throws -> [Repo]
  var fetchUserDetails: @Sendable (String) async throws -> User
}

extension DependencyValues {
  var networkClient: NetworkClient {
    get { self[NetworkClient.self] }
    set { self[NetworkClient.self] = newValue }
  }
}

extension NetworkClient {
  static let mockValue = Self(
    fetchLoginUser: {
      return .mockOne
    },
    fetchUsers: { _, _ in
      return [
        .mockOne,
        .mockTwo,
      ]
    },
    fetchRepoList: { _, _, _ in
      return [
        .mockOne,
        .mockTwo,
      ]
    },
    fetchUserDetails: { _ in
      return .mockOne
    }
  )

  static let failing = Self(
    fetchLoginUser: {
      throw NetworkError.invalidResponse
    },
    fetchUsers: { _, _ in
      throw NetworkError.decodingError
    },
    fetchRepoList: { _, _, _ in
      throw NetworkError.dataError
    },
    fetchUserDetails: { _ in
      throw NetworkError.invalidURL
    }
  )
}

extension NetworkClient: DependencyKey {
  static let liveValue: NetworkClient = {
    let service = NetworkService()
    return Self(
      fetchLoginUser: {
        try await service.request(api: .loginUser)
      },
      fetchUsers: { perPage, since in
        try await service.request(
          api: .listOfUsers(perPage: perPage, since: since))
      },
      fetchRepoList: { username, page, perPage in
        try await service.request(
          api: .fetchUserRepos(username: username, perPage: perPage, page: page)
        )
      },
      fetchUserDetails: { username in
        try await service.request(api: .userDetails(username))
      }
    )
  }()

  static let previewValue: NetworkClient = mockValue
  static let testValue: NetworkClient = mockValue
}
