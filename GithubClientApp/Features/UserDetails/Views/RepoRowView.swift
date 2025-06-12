//
//  RepoRowView.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 11/6/25.
//

import SwiftUI

struct RepoRowView: View {
  let repo: Repo

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text(repo.name ?? "")
          .font(.headline)
          .foregroundStyle(.black)

        Spacer()

        if let language = repo.language {
          Text(language)
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color.gray.opacity(0.2))
            .clipShape(Capsule())
        }
      }

      if let description = repo.description {
        Text(description)
          .font(.body)
          .foregroundColor(.secondary)
          .multilineTextAlignment(.leading)
      }

      HStack {
        Image(systemName: "star.fill")
          .foregroundColor(.yellow)

        Text("\(repo.stargazersCount ?? 0)")
          .font(.caption)
          .foregroundStyle(.black)
      }
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(10)
    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
  }
}
