# ImageCard-File-Generator
![](https://github.com/HuangRunHua/ImageCard-File-Generator/blob/main/intro_mac.png)
一个.imagecard扩展名文件生成软件。

## .imagecard文件扩展名介绍
这是突发奇想的一个小项目，之所以将文件扩展名设置为.imagecard，是由于在思考扩展名的时候偶然翻开App Store看到了Today版块，觉得设计还不错就稍微借鉴了一下。软件在iPhone 12 Pro中运行结果如下
![](https://github.com/HuangRunHua/ImageCard-File-Generator/blob/main/intro_ios.jpg)
你会发现，实际上一个imagecard只包含四个部分：
- 背景图片(image)
- 内容标签(Tag)
- 标题(title)
- 副标题(subtitle)

```swift
struct ImageCard: Codable {
    var id = UUID()
    let image: String
    let tag: String
    let title: String
    let subtitle: String
}
```

数据保存方面采用`PropertyListEncoder()`来编码一个ImageCard对象：
```swift
static func saveCard(_ imagecard: ImageCard) {
        let propertyListEncoder = PropertyListEncoder()
        let codedImageCard = try? propertyListEncoder.encode(imagecard)
        print("archiveURL = \(archiveURL)")
        try? codedImageCard?.write(to: archiveURL, options: .noFileProtection)
}
```
每当保存一个新的ImageCard对象时便调用此方法，即一个.imagecard文件所包含的内容为一个编码后的ImageCard对象。

## 安装环境
- Xcode 12.4.1+
- iOS/iPadOS 14.0+
- macOS 11.0+

> 关于Mac版的你可以在Release内找到并下载，iOS/iPadOS版的安装需要提前准备一台Mac并安装好Xcode，因为我并没有发布这款阅读器到App Store的想法（手动狗头）。

## 使用方法
软件内部设定了五个ImageCard对象，如下:
```swift
static var AllCards: [ImageCard] = [
        ImageCard(image: "dog", tag: "Dog", title: "盛夏的果实", subtitle: "我终将青春还给了她"),
        ImageCard(image: "spring", tag: "Spring", title: "斯人若彩虹", subtitle: "你说“呢”的时候，有春天的气息。"),
        ImageCard(image: "autumn", tag: "Autumn", title: "秋日私语", subtitle: "我的宇宙为你私藏了无数的温柔"),
        ImageCard(image: "winter", tag: "Winter", title: "Cold Winter", subtitle: "那些落在云彩里的爱心，每一个都是我对你没藏住的怦然心动。"),
        ImageCard(image: "love", tag: "Love", title: "起风了", subtitle: "风带着我的秘密吹过一整片森林，于是每一棵树都知道，我喜欢你。")
]
```
点击新建卡片按钮后，随机从这五个卡片中选出一个卡片并展示选中的卡片。通过分享卡片按钮可将生成的.imagecard文件分享给其他人。

## .imagecard文件阅读器
如果要预览生成的.imagecard文件，请访问[ImageCard File Viewer]()

## 后记
如果不出意外的话，我将不会更新这个文档（手动狗头）因为好玩的东西太多了～

