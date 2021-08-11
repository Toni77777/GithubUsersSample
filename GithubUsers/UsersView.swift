//
//  UsersView.swift
//  GithubUsers
//
//  Created by Anton Paliakou on 8/12/21.
//

import SwiftUI

struct UsersView: View {
    
    @State private var users: [User] = []

    var body: some View {
        List(users) { user in
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: user.avatarUrl)) { avatar in
                    avatar
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(16)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                
                Text(user.login)
                    .font(.title2)
            }.padding(.init(top: 4, leading: 0, bottom: 4, trailing: 0))
        }.task {
            self.users = await loadUsers()
        }
    }
    
    // MARK: - Private
    
    private func loadUsers() async -> [User] {
        guard let url = URL(string: "https://api.github.com/users") else { return [] }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([User].self, from: data)
        } catch {
            Swift.print(error)
            return []
        }
    }
}
