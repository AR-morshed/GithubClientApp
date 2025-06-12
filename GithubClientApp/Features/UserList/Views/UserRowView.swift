//
//  UserRowView.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 11/6/25.
//

import SwiftUI

struct UserRowView: View {
  let user: User

  var body: some View {
    HStack {
      UserAvatarView(user.avatarUrl, size: 40)

      Text(user.login)
        .font(.headline)
        .foregroundStyle(.black)
        .padding(.leading, 8)

      Spacer()
    }
    .padding(.horizontal)
  }
}
