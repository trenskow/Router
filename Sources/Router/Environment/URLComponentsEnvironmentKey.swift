//
//  URLComponentsEnvironmentKey.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

struct URLComponentsEnvironmentKey: EnvironmentKey {
	static let defaultValue: URLComponents? = nil
}

extension EnvironmentValues {
	public var urlComponents: URLComponents? {
		get { self[URLComponentsEnvironmentKey.self] }
		set { self[URLComponentsEnvironmentKey.self] = newValue }
	}
}
