//
//  EndpointView.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

@MainActor
struct EndpointView<Content: View>: MountPoint {

	let content: () -> Content

	init(
		@ViewBuilder content: @escaping () -> Content
	) {
		self.content = content
	}

	func handles(
		pathComponents: [String],
		queryItems: [URLQueryItem]
	) -> Bool {
		return pathComponents.isEmpty
	}
	
	func view(
		for pathComponents: [String],
		in urlComponents: URLComponents
	) throws -> AnyView {

		guard pathComponents.isEmpty else {
			throw RouterError.invalidUrl
		}

		return AnyView(self.content())

	}

}
