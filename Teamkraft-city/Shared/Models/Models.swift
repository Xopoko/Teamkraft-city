struct ApiResponse: Decodable {
    var result: [ApiCountry]
}

struct ApiCountry: Decodable {
    var cityList: [ApiCity]
}

struct ApiCity: Decodable {
    var title: String
}
