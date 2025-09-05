//
//  EndpointParamterizedView.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

struct EndpointParamterizedView<Content: View, Parameter: Decodable>: MountPoint {

	let content: (Parameter) -> Content

	init(
		_ type: Parameter.Type,
		content: @escaping (Parameter) -> Content
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
				Parameter.self,
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

		let parameters = try QueryCoder.TopLevelDecoder().decode(
			Parameter.self,
			from: Dictionary<String, QueryCoder.ItemType>.from(
				dictionary: (urlComponents.queryItems ?? []).toDictionary()
			))

		return AnyView(self.content(parameters))

	}

}
