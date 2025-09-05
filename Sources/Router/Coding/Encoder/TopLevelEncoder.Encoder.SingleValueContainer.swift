//
//  TopLevelEncoder.Encoder.SingleValueContainer.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

extension QueryCoder.TopLevelEncoder.Encoder {

	struct SingleValueContainer: SingleValueEncodingContainer {

		let codingPath: [CodingKey]
		let userInfo: [CodingUserInfoKey: Any]

		let result: Result

		init(
			codingPath: [CodingKey],
			userInfo: [CodingUserInfoKey : Any],
			result: Result
		) {
			self.codingPath = codingPath
			self.userInfo = userInfo
			self.result = result
		}

		func encodeNil() throws { }

		func encode(
			_ value: Bool
		) throws {
			self.result.items[""] = .constant(value ? "true" : "false")
		}

		func encode(
			_ value: String
		) throws {
			self.result.items[""] = .constant(value)
		}

		func encode(
			_ value: Double
		) throws {
			self.result.items[""] = .constant("\(value)")
		}

		func encode(
			_ value: Float
		) throws {
			self.result.items[""] = .constant("\(value)")
		}

		func encode(
			_ value: Int
		) throws {
			self.result.items[""] = .constant("\(value)")
		}

		func encode(
			_ value: Int8
		) throws {
			self.result.items[""] = .constant("\(value)")
		}

		func encode(
			_ value: Int16
		) throws {
			self.result.items[""] = .constant("\(value)")
		}

		func encode(
			_ value: Int32
		) throws {
			self.result.items[""] = .constant("\(value)")
		}

		func encode(
			_ value: Int64
		) throws {
			self.result.items[""] = .constant("\(value)")
		}

		func encode(
			_ value: UInt
		) throws {
			self.result.items[""] = .constant("\(value)")
		}

		func encode(
			_ value: UInt8
		) throws {
			self.result.items[""] = .constant("\(value)")
		}

		func encode(
			_ value: UInt16
		) throws {
			self.result.items[""] = .constant("\(value)")
		}

		func encode(
			_ value: UInt32
		) throws {
			self.result.items[""] = .constant("\(value)")
		}

		func encode(
			_ value: UInt64
		) throws {
			self.result.items[""] = .constant("\(value)")
		}

		func encode<T>(
			_ value: T
		) throws where T : Encodable {

			let result = Result()

			self.result.items[""] = .container(result)

			try value.encode(
				to: QueryCoder.TopLevelEncoder.Encoder(
					codingPath: self.codingPath,
					userInfo: self.userInfo,
					result: result))

		}

	}

}
