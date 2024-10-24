//
//  UserView+ViewModel.swift
//  Github-Combine-SwiftUI
//
//  Created by Francisco Rosa on 22/10/2024.
//

import Combine
import SwiftUI

extension UserView {
    
    @MainActor
    class ViewModel: ObservableObject {
            
        @Published var user: User?
        @Published var search: String = ""
        @Published var cancellables: Set<AnyCancellable> = []
        
        var searchSubject = CurrentValueSubject<String, Never>("")
        
        let httpClient: HTTPClient
        
        var userAvatarURL: URL? {
            URL(string: user?.avatarURL ?? "")
        }
        
        init(httpClient: HTTPClient) {
            self.httpClient = httpClient
        }
        
        func setupSearchPublisher() {
            searchSubject
                .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
                .sink { [weak self] searchText in
                    self?.loadUser(search: searchText)
                }
                .store(in: &cancellables)
        }
        
        private func loadUser(search: String) {
            httpClient.fetchUser(search: search)
                .sink { _ in
                    
                } receiveValue: { [weak self] user in
                    withAnimation {
                        self?.user = user
                    }
                }
                .store(in: &cancellables)
        }
        
        var companyInfoViewModel: UserInfoCardView.ViewModel {
            return UserInfoCardView.ViewModel(title: "Company", description: user?.company ?? "N/A")
        }
        
        var usernameInfoViewModel: UserInfoCardView.ViewModel {
            return UserInfoCardView.ViewModel(title: "Username", description: user?.name ?? "N/A")
        }
        
        var locationInfoViewModel: UserInfoCardView.ViewModel {
            return UserInfoCardView.ViewModel(title: "Location", description: user?.location ?? "N/A")
        }
        
        var followersInfoViewModel: UserInfoCardView.ViewModel {
            return UserInfoCardView.ViewModel(title: "Followers", description: String(describing: user?.followers ?? 0))
        }
        
        var publicReposInfoViewModel: UserInfoCardView.ViewModel {
            return UserInfoCardView.ViewModel(title: "Public repos", description: String(describing: user?.publicRepos ?? 0))
        }
        
        var publicGistsInfoViewModel: UserInfoCardView.ViewModel {
            return UserInfoCardView.ViewModel(title: "Public gists", description: String(describing: user?.publicGists ?? 0))
        }
    }
}
