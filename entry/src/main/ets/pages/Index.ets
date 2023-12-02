import http from '@ohos.net.http';
import router from '@ohos.router'

let httpRequest = http.createHttp();

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
struct Index {
  @State QueryHistory: ListHistory[] = AppStorage.SetAndLink('QueryHistory', []).get()

  build() {
    Column() {
      Search({ placeholder: '输入电话号码' })
        .searchButton('查询')
        .height(40)
        .margin(20)
        .onSubmit((value: string) => {
          httpRequest.request("https://apis.juhe.cn/mobile/get?dtype=&key=68b22126dba600fc2d240a8ef5a43270&phone=" + value, {
            header: {
              'Content-Type': 'application/json'
            }
          }).then((data) => {
            console.info('Result:' + data.result);
            const res = JSON.parse(<string> data.result);
            let item: ListHistory = {
              number: value,
              area: res.result.province + " · " + res.result.city,
              areacode: res.result.areacode,
              zip: res.result.zip,
              company: res.result.company,
              province: res.result.province,
              city: res.result.city
            }
            console.log(JSON.stringify(item))
            this.QueryHistory.push(item);
            AppStorage.Set('QueryHistory', this.QueryHistory);
          }).catch((err) => {
            console.info('error:' + JSON.stringify(err));
          });
        })
      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() {
          Column() {
            List({ space: 10, initialIndex: 0 }) {
              ForEach(this.QueryHistory, (item, index) => {
                ListItem() {
                  Row() {
                    Image($r("app.media.express"))
                      .margin({ top: 10, bottom: 10, right: 10 })
                      .height(54)
                    Column() {
                      Text(item.number)
                        .fontSize(16)
                        .fontWeight(FontWeight.Bold)
                      Text(item.area)
                        .fontSize(12)
                      Text(item.company)
                        .fontSize(12)
                        .maxLines(2)
                      Text(item.zip + " · " + item.areacode)
                        .fontSize(12)
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
                .onClick(() => {
                  AppStorage.SetOrCreate('Query', item);
                  router.pushUrl({
                    url: 'pages/Detail'
                  })
                })
              }, item => item)
            }
            .padding(10)
          }.width('100%').height('100%')
        }.tabBar(`查询历史`)
      }
      .barHeight(48)
      .backgroundColor('#F1F3F5')
      .flexShrink(1)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }
}