//
//  UserView.swift
//  Github-Combine-SwiftUI
//
//  Created by Francisco Rosa on 22/10/2024.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: Margins.m32.rawValue) {
                ZStack(alignment: .top) {
                    AsyncImage(url: viewModel.userAvatarURL) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: Size.s150.rawValue, height: Size.s150.rawValue)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray235)
                            .clipShape(.circle)
                            .frame(width: Size.s150.rawValue, height: Size.s150.rawValue)
                    }
                    .clipShape(.circle)
                    .zIndex(1)
                    
                    VStack(alignment: .center, spacing: Margins.m16.rawValue) {
                        
                        Text(viewModel.user?.login ?? "...")
                            .font(.system(size: FontSize.s30.rawValue, weight: .bold))
                            .underline()
                            .foregroundStyle(.black38)
                        
                        HStack(alignment: .top, spacing: Margins.m4.rawValue) {
                            UserInfoCardView(viewModel: viewModel.companyInfoViewModel)
                            UserInfoCardView(viewModel: viewModel.usernameInfoViewModel)
                            UserInfoCardView(viewModel: viewModel.locationInfoViewModel)
                        }
                    }
                    .padding(
                        EdgeInsets(
                            top: Margins.m85.rawValue,
                            leading: Margins.m16.rawValue,
                            bottom: Margins.m32.rawValue,
                            trailing: Margins.m16.rawValue
                        )
                    )
                    .background {
                        RoundedRectangle(cornerRadius: Radius.r16.rawValue)
                            .fill(.white)
                            .shadow(color: Color.black.opacity(0.3), radius: Radius.r16.rawValue, x: 0, y: 4)
                    }
                    .padding(.top, Size.s150.rawValue / 2)
                }
                
                HStack(alignment: .top, spacing: Margins.m4.rawValue) {
                    UserInfoCardView(viewModel: viewModel.followersInfoViewModel)
                    UserInfoCardView(viewModel: viewModel.publicReposInfoViewModel)
                    UserInfoCardView(viewModel: viewModel.publicGistsInfoViewModel)
                }
                .padding(
                    EdgeInsets(
                        top: Margins.m32.rawValue,
                        leading: Margins.m16.rawValue,
                        bottom: Margins.m32.rawValue,
                        trailing: Margins.m16.rawValue
                    )
                )
                .background {
                    RoundedRectangle(cornerRadius: Radius.r16.rawValue)
                        .fill(.white)
                        .shadow(color: Color.black.opacity(0.3), radius: Radius.r16.rawValue, x: 0, y: 4)
                }
                
                Spacer()
            }
            .padding(.vertical, Margins.m32.rawValue)
            .padding(.horizontal, Margins.m16.rawValue)
            .onAppear {
                viewModel.setupSearchPublisher()
            }
            .searchable(text: $viewModel.search)
            .onChange(of: viewModel.search) {
                viewModel.searchSubject.send(viewModel.search)
            }
        }
    }
}

#Preview {
    UserView(viewModel: UserView.ViewModel(httpClient: HTTPClient()))
}
