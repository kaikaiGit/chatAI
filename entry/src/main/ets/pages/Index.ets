/* 导入AI对话的api方法 */
import requestAI from '../../APIs/requestAI'

/* 导入AI对话的相关数据模型 */
import { Message } from '../../models/XunFeiAI'

@Entry
@Component
struct Index {
  @State message: string = ''; // 用户当前的问题
  @StorageLink("chatListProp") chatList: Array<Message> = new Array<Message>();
  @State isThinking: boolean = false;

  build() {
    Column() {
      /* 顶部栏 */
      Row() {
        // 返回
        Image($r("app.media.back"))
          .objectFit(ImageFit.Fill)
          .height(30)
          .margin({ left: 10 })

        Text(this.isThinking ? $r("app.string.Typing_Text") : $r("app.string.EntryAbility_label"))
          .fontSize(20)
          .letterSpacing(1)

        // 清空
        Image($r("app.media.clear"))
          .objectFit(ImageFit.Fill)
          .height(30)
          .margin({ right: 10 })
          .onClick(()=>{
            AppStorage.setOrCreate('chatListProp',[]);  // 清空存储区中的对话数据
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .height(50)
      .width("100%")
      .backgroundColor(Color.White)
      .expandSafeArea([SafeAreaType.KEYBOARD])

      /* 对话内容区域 */
      Scroll() {
        Column() {
          if(this.chatList.length == 0){
            Image($r("app.media.empty_pic"))
              .objectFit(ImageFit.Fill)
              .height(150)
              .margin({ top:"50%", left: 8 })
          }

          // 顶部预留一点空间
          Row()
            .height(10)

          // 对话列表
          ForEach(
            this.chatList,
            (item: Message, index: number) => {
              if (item.role == "user") {
                Row() {
                  Text(item.content)
                    .padding(14)
                    .backgroundColor("#95EC69")
                    .borderRadius(10)
                    .fontSize(20)
                    .lineHeight(24)
                    .constraintSize({maxWidth: "240vp"})
                  Image($r("app.media.userAvator"))
                    .objectFit(ImageFit.Fill)
                    .width(50)
                    .height(50)
                    .borderRadius(5)
                    .margin({ left: 8 })
                }
                .padding(10)
                .width("100%")
                .alignItems(VerticalAlign.Top)
                .justifyContent(FlexAlign.End)
              } else if (item.role == "assistant") {
                Row() {
                  Image($r("app.media.icon_AI"))
                    .objectFit(ImageFit.Fill)
                    .width(50)
                    .height(50)
                    .borderRadius(5)
                    .margin({ right: 8 })
                  Text(item.content)
                    .padding(14)
                    .backgroundColor(Color.White)
                    .borderRadius(10)
                    .fontSize(20)
                    .lineHeight(24)
                    .margin({ right: 0 })
                    .constraintSize({maxWidth: "240vp"})
                }
                .padding(10)
                .width("100%")
                .alignItems(VerticalAlign.Top)
                .justifyContent(FlexAlign.Start)
              }
            }
          )
        }
        .width("100%")
        .justifyContent(FlexAlign.Start)
      }
      .expandSafeArea([SafeAreaType.KEYBOARD])
      .backgroundColor("#EDEDED")
      .layoutWeight(1)
      .align(Alignment.Top)
      .padding({bottom: 40})

      /* 底部输入框区域 */
      Row() {
        TextInput({
          placeholder: "快来和 chatAI 聊天吧",text:this.message
        })
          .layoutWeight(8)
          .backgroundColor(Color.White)
          .onChange((msg: string) => {
            this.message = msg
          })
          .margin(10)

        Button("发送").onClick( async () => {
          // 加入用户的问题
          this.chatList.push({role: "user", content: this.message});
          // 设置为正在输入
          this.isThinking = true;
          // 调用AI对话接口获取回答
          requestAI(this.message)
            .then((res: Message) => {
              this.chatList.push(res); // 加入AI的回答
              this.isThinking = false;
            })
            .catch((error: Error) => {
              this.chatList.push({role: "assistant", content: "我不知道啊。"})
              this.isThinking = false;
            })
          // 清空输入框的值
          this.message = "";
        })
          .margin({right: 10})
      }
      .width("100%")
      .backgroundColor("#F7F7F7")
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
  }


}