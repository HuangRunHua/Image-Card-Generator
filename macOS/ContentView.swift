//
//  ContentView.swift
//  Shared
//
//  Created by Runhua Huang on 2021/7/11.
//

import SwiftUI

struct ContentView: View {
    
    @State var card: ImageCard = ImageCard(image: "intro", tag: "Introduction", title: "ImageCard 使用说明", subtitle: "点击新建按钮创建新的卡片\n点击分享按钮共享创建的卡片")
    
    @State private var showShareSheet = false
    @State private var canShare = false
    
    var body: some View {
        VStack {
            Image(card.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 400)
                .cornerRadius(20)
                .overlay(
                    VStack(alignment: .leading){
                        Text(card.tag)
                            .foregroundColor(Color.white)
                            .font(.system(size: 15, weight: .bold, design: .rounded))

                        Text(card.title)
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .bold, design: .rounded))

                        Spacer()

                        Text(card.subtitle)
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                    }.padding()
                    , alignment: .leading)
                .shadow(color: .gray, radius: 5, y: 5)
            
            RoundedRectangle(cornerRadius: 6)
                .frame(width: 200, height: 50)
                .foregroundColor(Color.gray)
                .opacity(0.4)
                .overlay(
                    Button(action: {
                        let randomIndex = Int(arc4random_uniform(UInt32(ImageCard.AllCards.count)))
                        let imageCard = ImageCard.AllCards[randomIndex]
                        ImageCard.saveCard(imageCard)
                        self.canShare = true
                        card = imageCard
                    }) {
                        HStack {
                            Image(systemName: "doc.badge.plus")
                                .font(.title)
                                .foregroundColor(.purple)
                            Text("New Card")
                                .foregroundColor(.purple)
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                       
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 200, height: 50)
                )
                .padding([.top])
            
            if self.canShare {
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: 200, height: 50)
                    .foregroundColor(Color.gray)
                    .opacity(0.4)
                    .overlay(
                        Button(action: {
                            let manager = FileManager.default
                            let urlForDocument = manager.urls( for: .desktopDirectory, in:.userDomainMask)
                            let url = urlForDocument[0]
                            createFile(fileBaseUrl: url, imagecard: card)
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.title)
                                    .foregroundColor(.purple)
                                Text("Share Card")
                                    .foregroundColor(.purple)
                                    .font(.system(size: 17, weight: .bold, design: .rounded))
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 200, height: 50)
                    )
                    .padding([.bottom])
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
    
    //根据文件名和路径创建文件
    func createFile(fileBaseUrl:URL, imagecard: ImageCard){
        let manager = FileManager.default
             
        let file = fileBaseUrl.appendingPathComponent("MyImageCard.imagecard")
        print("文件: \(file)")
        let exist = manager.fileExists(atPath: file.path)
        if !exist {
            let createSuccess = manager.createFile(atPath: file.path,contents:nil,attributes:nil)
            print("文件创建结果: \(createSuccess)")
        }
        
        
        let propertyListEncoder = PropertyListEncoder()
        let codedImageCard = try? propertyListEncoder.encode(imagecard)
        try? codedImageCard?.write(to: file.absoluteURL, options: .noFileProtection)
    }
}
    




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
