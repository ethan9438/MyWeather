import XCTest
@testable import MyLibrary

final class MyLibraryTests: XCTestCase {
    func testIsLuckyBecauseWeAlreadyHaveLuckyNumber() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(8)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsLuckyBecauseWeatherHasAnEight() async throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsNotLucky() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsNotLuckyBecauseServiceCallFails() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNil(isLuckyNumber)
    }
    func testWeather() async throws{
        //Given
        let jsonString: String = """
                        {
                          "coord": {
                            "lon": 74.006,
                            "lat": 40.7128
                          },
                          "weather": [
                            {
                              "id": 804,
                              "main": "Clouds",
                              "description": "overcast clouds",
                              "icon": "04n"
                            }
                          ],
                          "base": "stations",
                          "main": {
                            "temp": 267.74,
                            "feels_like": 263.86,
                            "temp_min": 267.74,
                            "temp_max": 267.74,
                            "pressure": 1019,
                            "humidity": 76,
                            "sea_level": 1019,
                            "grnd_level": 635
                          },
                          "visibility": 10000,
                          "wind": {
                            "speed": 2.39,
                            "deg": 178,
                            "gust": 2.16
                          },
                          "clouds": {
                            "all": 88
                          },
                          "dt": 1664566862,
                          "sys": {
                            "country": "KG",
                            "sunrise": 1664585995,
                            "sunset": 1664628447
                          },
                          "timezone": 21600,
                          "id": 8145969,
                          "name": "Kara-Kulja",
                          "cod": 200
                        }
        """
        //When

        let jsonData: Data = jsonString.data(using: .utf8)!
        let decoder: JSONDecoder = JSONDecoder()
        let testData: Weather = try! decoder.decode(Weather.self, from: jsonData)

        //Then
        XCTAssert(testData.main.temp == 267.74)
    }

}
