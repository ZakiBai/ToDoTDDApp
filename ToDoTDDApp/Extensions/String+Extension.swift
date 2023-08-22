//
//  String+Extension.swift
//  ToDoTDDApp
//
//  Created by Zaki on 22.08.2023.
//

import Foundation

extension String {
    var percentEncoded: String {
        let allowedCharacters = CharacterSet(charactersIn: "~!@#$%^&*()_+-=[]\\{}'/?.,<>").inverted
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else { fatalError() }
        return encodedString
    }
}
