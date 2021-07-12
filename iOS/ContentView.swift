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
                            showShareSheet = true
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
                        .sheet(isPresented: $showShareSheet) {
                            let url = ImageCard.archiveURL
                            ShareSheet(activityItems: [url])
                        }
                    )
                    .padding([.bottom])
            }
        }
    }
       
}
    




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#if os(iOS)
struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void

    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}
#endif
