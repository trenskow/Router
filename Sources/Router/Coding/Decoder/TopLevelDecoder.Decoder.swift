//
//  TopLevelDecoder.Decoder.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

extension QueryCoder.TopLevelDecoder {

	struct Decoder: Swift.Decoder {

		let codingPath: [CodingKey]
		let userInfo: [CodingUserInfoKey : Any]

		let items: [String: QueryCoder.ItemType]

		init(
			codingPath: [CodingKey],
			userInfo: [CodingUserInfoKey : Any],
			items: [String: QueryCoder.ItemType]
		) {
			self.codingPath = codingPath
			self.userInfo = userInfo
			self.items = items
		}

		func container<Key>(
			keyedBy type: Key.Type
		) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
			return KeyedDecodingContainer(
				KeyedContainer<Key>(
					codingPath: self.codingPath,
					userInfo: self.userInfo,
					items: self.items))
		}
		
		func unkeyedContainer() throws -> any UnkeyedDecodingContainer {
			return UnkeyedContainer(
				codingPath: self.codingPath,
				userInfo: self.userInfo,
				items: self.items)
		}
		
		func singleValueContainer() throws -> any SingleValueDecodingContainer {
			return SingleValueDecoder(
				codingPath: self.codingPath,
				userInfo: self.userInfo,
				items: self.items)
		}

	}

}
