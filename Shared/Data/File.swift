//
//  File.swift
//  Image Card Viewer
//
//  Created by Runhua Huang on 2021/7/11.
//

import Foundation
import SwiftUI

struct ImageCard: Codable {
    var id = UUID()
    let image: String
    let tag: String
    let title: String
    let subtitle: String
    
    static var AllCards: [ImageCard] = [
        ImageCard(image: "dog", tag: "Dog", title: "盛夏的果实", subtitle: "我终将青春还给了她"),
        ImageCard(image: "spring", tag: "Spring", title: "斯人若彩虹", subtitle: "你说“呢”的时候，有春天的气息。"),
        ImageCard(image: "autumn", tag: "Autumn", title: "秋日私语", subtitle: "我的宇宙为你私藏了无数的温柔"),
        ImageCard(image: "winter", tag: "Winter", title: "Cold Winter", subtitle: "那些落在云彩里的爱心，每一个都是我对你没藏住的怦然心动。"),
        ImageCard(image: "love", tag: "Love", title: "起风了", subtitle: "风带着我的秘密吹过一整片森林，于是每一棵树都知道，我喜欢你。"),
    ]
    
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static var archiveURL = documentDirectory.appendingPathComponent("winterImageCard").appendingPathExtension("imagecard")
    
    static func loadCards() -> ImageCard? {
        guard let codedCards = try? Data(contentsOf: archiveURL) else {
            return nil
        }
        print(archiveURL)
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(ImageCard.self, from: codedCards)
    }
    
    static func saveCard(_ imagecard: ImageCard) {
        let propertyListEncoder = PropertyListEncoder()
        let codedImageCard = try? propertyListEncoder.encode(imagecard)
        print("archiveURL = \(archiveURL)")
        try? codedImageCard?.write(to: archiveURL, options: .noFileProtection)
    }
}




