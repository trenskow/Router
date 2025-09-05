//
//  MountPoint.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

@MainActor
public protocol MountPoint: Sendable {

	func handles(
		pathComponents: [String],
		queryItems: [URLQueryItem]
	) -> Bool

	func view(
		for pathComponents: [String],
		in urlComponents: URLComponents
	) throws -> AnyView

}
