//
//  Dictionary.String.String+Transform.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import Foundation

extension Dictionary where Key == String, Value == String {

	func toQueryItems() -> [URLQueryItem] {
		return self.map {
			return URLQueryItem(
				name: $0.key,
				value: $0.value)
		}
	}

}
