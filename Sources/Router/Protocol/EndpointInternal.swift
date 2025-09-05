//
//  EndpointInternal.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

@MainActor
protocol EndpointInternal {
	var routes: [String: MountPoint] { get set }
	var notFound: AnyView? { get set }
}

extension EndpointInternal {

	func _handles(
		pathComponents: [String],
		queryItems: [URLQueryItem]
	) -> Bool {

		guard
			let first = pathComponents.first
		else {
			return false
		}

		return self.routes.keys.contains(first) || self.notFound != nil

	}

	func _view(
		for pathComponents: [String],
		in urlComponents: URLComponents
	) throws -> AnyView {

		guard
			let first = pathComponents.first,
			let endpoint = self.routes[first]
		else {

			guard
				let notFound = self.notFound
			else {
				throw RouterError.invalidUrl
			}

			return notFound

		}

		return try endpoint.view(
			for: pathComponents.dropFirst().map { $0 },
			in: urlComponents)

	}

	func _mount(
		at pathComponent: String,
		endpoint: MountPoint
	) -> Self {
		var copy = self
		copy.routes[pathComponent] = endpoint
		return copy
	}

	public func _mount<Content: View>(
		at pathComponent: String,
		@ViewBuilder content: @escaping () -> Content
	) -> Self {
		return self._mount(
			at: pathComponent,
			endpoint: EndpointView(
				content: content))
	}

	public func _mount<Data: Decodable, Content: View>(
		at pathComponent: String,
		_ type: Data.Type,
		content: @escaping (Data) -> Content
	) -> Self {
		return self._mount(
			at: pathComponent,
			endpoint: EndpointDataView(
				type,
				content: content))
	}

	func _onNotFound(
		view: AnyView
	) -> Self {
		var copy = self
		copy.notFound = view
		return copy
	}

}
