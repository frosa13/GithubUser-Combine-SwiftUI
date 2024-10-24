//
//  UserInfoCardView.swift
//  Github-Combine-SwiftUI
//
//  Created by Francisco Rosa on 23/10/2024.
//

import SwiftUI

struct UserInfoCardView: View {
    
    var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: Margins.m8.rawValue) {
            Text(viewModel.title)
                .font(.system(size: FontSize.s16.rawValue, weight: .bold))
                .foregroundStyle(.black38)
                .lineLimit(2)
            
            Text(viewModel.description)
                .font(.system(size: FontSize.s14.rawValue))
                .foregroundStyle(.black38)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(Margins.m8.rawValue)
        .background {
            RoundedRectangle(cornerRadius: Radius.r16.rawValue)
                .fill(.gray235)
        }
    }
}

#Preview {
    UserInfoCardView(
        viewModel:
            UserInfoCardView.ViewModel(
                title: "Username",
                description: "my_username_123"
            )
    )
}

extension UserInfoCardView {
    
    @MainActor class ViewModel: ObservableObject {
        let title: String
        let description: String
        
        init(title: String, description: String) {
            self.title = title
            self.description = description
        }
    }
}
