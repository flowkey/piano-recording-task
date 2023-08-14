import Foundation

typealias GraphQLRequestString = String

struct GraphQLQuery: Codable {
    private let query: GraphQLRequestString
    private let variables: [String: String]

    enum CodingKeys: CodingKey {
        case query, variables
    }

    var rawValue: String {
        return String(decoding: try! JSONEncoder().encode(self), as: UTF8.self)
    }

    init(requestString: GraphQLRequestString, variables: [String: String]) {
        self.query = requestString
        self.variables = variables
    }
}

struct GraphQLResult<T: Decodable>: Decodable {
    let data: T?
    let errors: [GraphQLError]?
}

struct GraphQLError: Decodable {
    let message: [String]
    let path: [String]
}

@MainActor
class GraphQLClient {
    private let url: String
    private let urlLoader = URLLoader()

    init(url: String) {
        self.url = url
    }

    func fetch(_ query: GraphQLQuery) async throws -> Data {
        let headers: [String: String] = ["Content-Type": "application/json; charset=utf-8"]
        let body = query.rawValue
        return try await urlLoader.load(from: url, method: "POST", body: body, headers: headers)
    }
}


private class URLLoader {
    let urlSession: URLSession

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 6
        configuration.timeoutIntervalForRequest = 10 // for each download
        configuration.timeoutIntervalForResource = 120 // for *all* downloads
        urlSession = URLSession(configuration: configuration)
    }

    func load(from url: String, method: String? = nil, body: String? = nil, headers: [String: String] = [:]) async throws -> Data {
        var request = URLRequest(url: URL(string: url)!)

        if let method = method {
            request.httpMethod = method
        }

        for (headerName, headerValue) in headers {
            request.setValue(headerValue, forHTTPHeaderField: headerName)
        }

        if let body = body {
            request.httpBody = body.data(using: .utf8)
        }

        let (data, response) = try await urlSession.data(for: request)
        guard let response = response as? HTTPURLResponse, (200 ..< 300).contains(response.statusCode) else {
            throw URLError.badResponse(request, String(data: data, encoding: .utf8), response)
        }

        return data
    }

    deinit {
        urlSession.finishTasksAndInvalidate() // kill memory leaks
    }
}

enum URLError: Error {
    case badResponse(URLRequest, String?, URLResponse?)
}
