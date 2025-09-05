//
//  Navigator.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

public struct Navigator: Sendable {

	private var baseUrl: URL
	@Binding var navigationStack: [URL]

	init(
		baseUrl: URL,
		navigationStack: Binding<[URL]>
	) {
		self.baseUrl = baseUrl
		self._navigationStack = navigationStack
	}

	public func push(
		relativePath: String
	) throws {

		guard
			let url = URL(string: relativePath,
						  relativeTo: self.navigationStack.last ?? self.baseUrl)
		else {
			throw RouterError.invalidUrl
		}

		self.navigationStack
			.append(
				url)
	}

	public func push<Parameter: Encodable>(
		relativePath: String,
		parameter: Parameter
	) throws {

		let queryItems = try QueryCoder.TopLevelEncoder().encode(parameter)
			.toDictionary()
			.toQueryItems()

		guard
			let url = URL(
				string: relativePath,
				relativeTo: self.navigationStack.last ?? self.baseUrl),
			var components = url.components
		else {
			throw RouterError.invalidUrl
		}

		components.queryItems = (components.queryItems ?? []) + queryItems

		guard
			let url = components.url
		else {
			throw RouterError.invalidUrl
		}

		self.navigationStack
			.append(
				url)

	}

	public func pop() {

		guard
			self.navigationStack.isEmpty
		else {
			return
		}

		self.navigationStack.removeLast()

	}

}
