//
//  TopUserInfoView.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 11/6/25.
//

import SwiftUI

struct TopUserInfoView: View {
  let user: User

  var body: some View {
    HStack(spacing: 12) {
      UserAvatarView(user.avatarUrl, size: 60)

      VStack(alignment: .leading, spacing: 4) {
        Text(user.login)
          .font(.title2.bold())

        HStack(spacing: 12) {
          Text("Followers: \(user.followers ?? 0)")
          Text("Following: \(user.following ?? 0)")
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
      }
    }
    .padding()
  }
}
