//
//  UserListRow.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 11/6/25.
//

import SwiftUI

struct UserListRow: View {
  let user: User
  let isLast: Bool
  let onAppear: () -> Void

  var body: some View {
    UserRowView(user: user)
      .onAppear {
        if isLast { onAppear() }
      }
  }
}
