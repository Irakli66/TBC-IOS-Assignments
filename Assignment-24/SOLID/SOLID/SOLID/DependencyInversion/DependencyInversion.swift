//
//  DependencyInversion.swift
//  SOLID
//
//  Created by irakli kharshiladze on 12.11.24.
//
//MARK: ამ მიდგომით "NewsManager" კლასი დამოკიდებულია აბსტრაქციაზე ("NewsServiceProtocol" პროტოკოლზე) ნაცვლად "NewsApiService" კლასისა. ეს საშუალებას გვაძლევს NewsApiService ჩავანაცვლოთ სხვა მეთოდით ბევრად მარტივად და მოქნილად.

protocol NewsServiceProtocol {
    func fetchNews() -> [String]
}

final class NewsApiServiceDIP: NewsServiceProtocol {
    func fetchNews() -> [String] {
        ["News"]
    }
}

final class NewsManagerDIP {
    private let newsService: NewsServiceProtocol
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
    
    func getNews() -> [String] {
        self.newsService.fetchNews()
    }
}

let newsApiService = NewsApiServiceDIP()
let newsManager = NewsManagerDIP(newsService: newsApiService)
let news = newsManager.getNews()
// print(news)
