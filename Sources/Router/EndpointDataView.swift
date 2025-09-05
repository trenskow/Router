//
//  EndpointDataView.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

struct EndpointDataView<Content: View, Data: Decodable>: MountPoint {

	let content: (Data) -> Content

	init(
		_ type: Data.Type,
		content: @escaping (Data) -> Content
	) {
		self.content = content
	}

	func handles(
		pathComponents: [String],
		queryItems: [URLQueryItem]
	) -> Bool {

		guard
			pathComponents.isEmpty,
			let _ = try? QueryCoder.TopLevelDecoder().decode(
				Data.self,
				from: Dictionary<String, QueryCoder.ItemType>.from(
					dictionary: queryItems.toDictionary()
				))
		else {
			return false
		}

		return true

	}

	func view(
		for pathComponents: [String],
		in urlComponents: URLComponents
	) throws -> AnyView {

		guard pathComponents.isEmpty else {
			throw RouterError.invalidUrl
		}

		let data = try QueryCoder.TopLevelDecoder().decode(
			Data.self,
			from: Dictionary<String, QueryCoder.ItemType>.from(
				dictionary: (urlComponents.queryItems ?? []).toDictionary()
			))

		return AnyView(self.content(data))

	}

}
