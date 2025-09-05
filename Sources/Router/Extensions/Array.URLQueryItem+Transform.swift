//
//  Array.URLQueryItem+Transform.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import Foundation

extension Array where Element == URLQueryItem {

	func toDictionary() -> [String: String] {
		var dictionary: [String: String] = [:]
		for item in self {
			dictionary[item.name] = item.value
		}
		return dictionary
	}

}
