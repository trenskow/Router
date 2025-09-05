//
//  TopLevelDecoder.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import Foundation
import Combine

extension CodingUserInfoKey {
	static let queryItems = Self(rawValue: "router.url")!
}

extension QueryCoder {

	struct TopLevelDecoder: Combine.TopLevelDecoder {

		let codingPath: [CodingKey]

		fileprivate init(
			codingPath: [CodingKey] = []
		) {
			self.codingPath = codingPath
		}

		public init() {
			self.init(
				codingPath: [])
		}

		func decode<T>(
			_ type: T.Type,
			from items: [String: ItemType]
		) throws -> T where T : Decodable {

			let decoder = Decoder(
				codingPath: self.codingPath,
				userInfo: [
					.queryItems: items
				],
				items: items)

			return try type.init(
				from: decoder)

		}

	}

}
