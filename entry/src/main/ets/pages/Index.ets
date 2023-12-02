import http from '@ohos.net.http';
import router from '@ohos.router'

let httpRequest = http.createHttp();

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
struct Index {
  @State QueryHistory: ListHistory[] = AppStorage.SetAndLink('QueryHistory', []).get()

  build() {
    Column() {
      Search({ placeholder: '输入要查询的成语' })
        .searchButton('查询')
        .height(40)
        .margin(20)
        .onSubmit((value: string) => {
          httpRequest.request("http://apis.juhe.cn/idioms/query?key=00587dc8bdc9740de313f19b85d08ebc&wd=" + value, {
            header: {
              'Content-Type': 'application/json'
            }
          }).then((data) => {
            console.info('Result:' + data.result);
            const res = JSON.parse(<string> data.result);
            let item: ListHistory = {
              name: value,
              pinyin: res.result.pinyin,
              jbsy: res.result.jbsy,
              xxsy: res.result.xxsy,
              chuchu: res.result.chuchu,
              liju: res.result.liju,
              jyc: res.result.jyc,
              fyc: res.result.fyc
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
                      Text(item.name)
                        .fontSize(16)
                        .fontWeight(FontWeight.Bold)
                      Text(item.pinyin)
                        .fontSize(12)
                      Text(item.jbsy.join('；'))
                        .fontSize(12)
                        .maxLines(1)
                      Text(item.chuchu)
                        .fontSize(12)
                        .maxLines(2)
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