//
//  String+Extension.swift
//  Github-Combine-SwiftUI
//
//  Created by Francisco Rosa on 22/10/2024.
//

import Foundation

extension String {
    
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
