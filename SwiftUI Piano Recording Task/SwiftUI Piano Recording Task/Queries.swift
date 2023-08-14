import Foundation

struct Song: Codable {
    let _id: String
    let title: String
    let keyStrokes: [Int]
}

@MainActor
func getSongs() async throws -> [Song] {
    let client = GraphQLClient(url: "http://127.0.0.1:4000/graphql")

    let songsQuery = GraphQLQuery(
        requestString: """
        query Songs {
          songs {
            _id
            keyStrokes
            title
          }
        }
        """,
        variables: [:]
    )

    let result = try await client.fetch(songsQuery)

    struct SongsQueryResult: Codable {
        let songs: [Song]
    }

    let decoder = JSONDecoder()
    let decoded = try! decoder.decode(
        GraphQLResult<SongsQueryResult>.self,
        from: result
    )

    guard let songs = decoded.data?.songs else {
        print("Could not fetch GraphQL data. Errors: \(decoded.errors ?? [])")
        return []
    }

    return songs
}
