//
//  NotDependencyInversion.swift
//  SOLID
//
//  Created by irakli kharshiladze on 12.11.24.
//
//MARK: ამ მიდგომის მინუსია არის რომ მაღალი წოდების მოდული "NewsManager1" არის დამოკიდებული დაბალი წოდების მოდულზე "NewsApiService1"-ზე. მაგალითად, რომ გვინდოდეს მონაცემის წყაროს შეცვლა უნდა განვაახლოთ "NewsManager1" კლასი. ასევე არ გვაქვს აბსტრაქცია და პროტოკოლი, რაც ზღუდავს მოქნილობას და ართულებს ტესტირებას.

final class NewsApiService {
    func fetchNews() -> [String] {
        ["News"]
    }
}

final class NewsManager {
    private let newsService = NewsApiService()
    
    func getNews() -> [String] {
        newsService.fetchNews()
    }
}

let newsManager1 = NewsManager()
let news1 = newsManager1.getNews()
//print(news1)
