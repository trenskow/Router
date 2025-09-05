//
//  EndpointLayout.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

public protocol EndpointLayout {

	associatedtype Layout: View

	init()

	@ViewBuilder
	func layout(
		content: AnyView
	) -> Layout

}
