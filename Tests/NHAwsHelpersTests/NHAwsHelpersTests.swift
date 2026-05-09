import Crypto
import Foundation
import HTTPTypes
import NHMacros
import Testing
@testable import NHAwsHelpers

struct AWSv4AuthTests {
	static let awsKey = "LCNRBZKKF8QEWNT2DYGM"
	static let awsSecret = "F2XxYE7h6zim2nCgNaUqZp9hGWqYzy7kbNMazR8g"
	static let awsURL = URL(string: """
		https://s3.us-west-1.wasabisys.com/demoproject/?list-type=2&prefix=demo-subfolder%2FA%20Folder
		""")!

	@Test
	func awsSigning() throws {
		let formatter = ISO8601DateFormatter()
		let date = try #require(formatter.date(from: "2022-07-15T06:43:24Z"))

		let info = AWSV4Signature(
			requestMethod: .get,
			url: Self.awsURL,
			date: date,
			awsKey: Self.awsKey,
			awsSecret: Self.awsSecret,
			awsRegion: .usWest1,
			awsService: .s3,
			hexContentHash: .fromData(Data("".utf8)),
			additionalSignedHeaders: [:])

		#expect(
			"""
			AWS4-HMAC-SHA256\n2022-07-15T06:43:24Z\n20220715/us-west-1/s3/aws4_request\ncc388e661c394a9b73dd2a71d1a20dd\
			890afb1433cb704549016be6a2af18cc5
			""" ==
			info.stringToSign)
		#expect("d3465b2bb220cf97a135c0746047bda485e70295f513048c192ca88ff50ecd18" == info.signature)
		#expect(
			"""
				AWS4-HMAC-SHA256 Credential=LCNRBZKKF8QEWNT2DYGM/20220715/us-west-1/s3/aws4_request,SignedHeaders=host;\
				x-amz-content-sha256,Signature=d3465b2bb220cf97a135c0746047bda485e70295f513048c192ca88ff50ecd18
				""" ==
			info.authorizationString)
	}
}
