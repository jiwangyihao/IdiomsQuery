import router from '@ohos.router'

interface ListHistory {
  name: string
  pinyin: string
  jbsy: string[]
  xxsy: string[]
  chuchu: string
  liju: string
  jyc: string[]
  fyc: string[]
}

@Entry
@Component
struct Detail {
  @State message: string = 'Hello World'
  @State Query: ListHistory = AppStorage.SetAndLink('Query', {
    "name": "",
    "pinyin": "",
    "jbsy": [],
    "xxsy": [],
    "chuchu": "",
    "liju": "",
    "jyc": [],
    "fyc": []
  }).get()

  build() {
    Row() {
      Column() {
        Text("<  成语详情")
          .fontSize(18)
          .width('100%')
          .margin({ top: 10, bottom: 20, left: 20 })
          .textAlign(TextAlign.Start)
          .fontColor('#017CFE')
          .onClick(() => {
            router.back()
          })

        Row() {
          Image($r("app.media.express"))
            .margin({ top: 10, bottom: 10, right: 10 })
            .height(54)
          Column() {
            Text(this.Query.name)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
            Text(this.Query.pinyin)
              .fontSize(12)
            Text(this.Query.jbsy.join('；'))
              .fontSize(12)
              .maxLines(1)
            Text(this.Query.chuchu)
              .fontSize(12)
              .maxLines(2)
          }
          .flexShrink(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Start)
        }
        .borderRadius(10)
        .padding(10)
        .backgroundColor('#fff')
        .width('100%')
        .margin({ bottom: 10 })

        Text("- 详细信息 -")
          .fontSize(16)
          .margin({ bottom: 10 })

        Scroll() {
          List({ space: 10, initialIndex: 0 }) {
            ListItem() {
              Row() {
                Column() {
                  Text("拼音")
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                  Text(this.Query.pinyin)
                    .fontSize(24)
                    .margin({ top: 10 })
                }
                .flexShrink(1)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .borderRadius(10)
              .padding(10)
              .backgroundColor('#fff')
            }
            .width('100%')
            ListItem() {
              Row() {
                Column() {
                  Text("详细释义")
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                  Text(this.Query.xxsy.join('\n'))
                    .fontSize(24)
                    .margin({ top: 10 })
                }
                .flexShrink(1)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .borderRadius(10)
              .padding(10)
              .backgroundColor('#fff')
            }
            .width('100%')
            ListItem() {
              Row() {
                Column() {
                  Text("出处")
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                  Text(this.Query.chuchu)
                    .fontSize(24)
                    .margin({ top: 10 })
                }
                .flexShrink(1)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .borderRadius(10)
              .padding(10)
              .backgroundColor('#fff')
            }
            .width('100%')
            ListItem() {
              Row() {
                Column() {
                  Text("近义词")
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                  Text(this.Query.jyc?this.Query.jyc.join('、'):"暂无")
                    .fontSize(24)
                    .margin({ top: 10 })
                }
                .flexShrink(1)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .borderRadius(10)
              .padding(10)
              .backgroundColor('#fff')
            }
            .width('100%')
            ListItem() {
              Row() {
                Column() {
                  Text("反义词")
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                  Text(this.Query.fyc?this.Query.fyc.join('、'):"暂无")
                    .fontSize(24)
                    .margin({ top: 10 })
                }
                .flexShrink(1)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .borderRadius(10)
              .padding(10)
              .backgroundColor('#fff')
            }
            .width('100%')
          }
        }
        .flexShrink(1)
      }
      .height('100%')
      .padding(10)
    }
    .height('100%')
    .backgroundColor('#eee')
  }
}