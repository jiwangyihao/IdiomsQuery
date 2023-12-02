import router from '@ohos.router'

interface ListHistory {
  number: string
  area: string
  areacode: string
  zip: string
  company: string
  province: string
  city: string
}

@Entry
@Component
struct Detail {
  @State message: string = 'Hello World'
  @State Query: ListHistory = AppStorage.SetAndLink('Query', {
    "number": "",
    "area": "",
    "areacode": "",
    "zip": "",
    "company": "",
    "province": "",
    "city": ""
  }).get()

  build() {
    Row() {
      Column() {
        Text("<  手机号详情")
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
            Text(this.Query.number)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
            Text(this.Query.area)
              .fontSize(12)
            Text(this.Query.company)
              .fontSize(12)
              .maxLines(2)
            Text(this.Query.zip+" · "+this.Query.areacode)
              .fontSize(12)
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
                  Text("省份")
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                  Text(this.Query.province)
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
                  Text("城市")
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                  Text(this.Query.city)
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
                  Text("运营商")
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                  Text(this.Query.company)
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
                  Text("地区编码")
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                  Text(this.Query.areacode)
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
                  Text("邮政编码")
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                  Text(this.Query.zip)
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