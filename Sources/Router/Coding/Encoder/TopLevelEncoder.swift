//
//  TopLevelEncoder.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import Foundation
import Combine

extension QueryCoder {

	struct TopLevelEncoder: Combine.TopLevelEncoder {

		typealias Output = [String: QueryCoder.ItemType]

		var codingKey: [CodingKey]

		init() {
			self.codingKey = []
		}

		func encode<T: Encodable>(
			_ value: T
		) throws -> [String : QueryCoder.ItemType] {

			let result = TopLevelEncoder.Encoder.Result()

			let encoder = QueryCoder.TopLevelEncoder.Encoder(
				codingPath: codingKey,
				userInfo: [:],
				result: result)

			try value.encode(
				to: encoder)

			return result.finalize()

		}

	}

}
