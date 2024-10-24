//
//  Github_Combine_SwiftUIApp.swift
//  Github-Combine-SwiftUI
//
//  Created by Francisco Rosa on 22/10/2024.
//

import SwiftUI

@main
struct Github_Combine_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            UserView(viewModel: UserView.ViewModel(httpClient: HTTPClient()))
        }
    }
}
